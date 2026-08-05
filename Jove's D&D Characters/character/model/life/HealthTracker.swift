import Foundation

public extension HealthCounterInfo {
	var deathSaveMaximum: Int { 3 }
	var deathSaveDie: Die { .d20 }

	var isDead: Bool {
		deathSaveFailures >= deathSaveMaximum
	}

	var isConscious: Bool {
		(hitPoints ?? 1) > 0 && !isDead
	}

	var isUnconscious: Bool {
		(hitPoints ?? 1) == 0 && !isDead
	}

	var needsDeathSavingThrow: Bool {
		isUnconscious && !isStable
	}
}

public enum LifeState: String, JCSEnum {
	case conscious
	case stable
	case dying
	case dead
}

public extension HealthCounterInfo {
	var lifeState: LifeState {
		if isDead {
			.dead
		} else if needsDeathSavingThrow {
			.dying
		} else if isUnconscious {
			.stable
		} else {
			.conscious
		}
	}
}

public enum DeathSaveResult: String, JCSEnum {
	case invalidRoll
	case notRequired

	case success
	case failure
	case twoFailures

	case stabilized
	case regainedConsciousness
	case died
}

public final class HealthTracker: HealthCounterInfo {
	public var maxHitPoints: Int? { _maxHitPoints }
	public var hitPoints: Int? { _hitPoints }
	public var temporaryHitPoints: Int? { _temporaryHitPoints }

	private var _maxHitPoints: Int
	private var _hitPoints: Int
	private var _temporaryHitPoints: Int

	public private(set) var hitDice: [Dice]
	public private(set) var remainingHitDice: [Dice]

	public private(set) var deathSaveSuccesses: Int
	public private(set) var deathSaveFailures: Int

	public private(set) var isStable: Bool

	public init(
		maxHitPoints: Int,
		hitPoints: Int,
		hitDice: [Dice] = [],
		remainingHitDice: [Dice] = [],
		temporaryHitPoints: Int,
		isStableAtZero: Bool = false
	) {
		let validatedMaximum = max(1, maxHitPoints)
		let validatedHitPoints = min(max(hitPoints, 0), validatedMaximum )
		self._maxHitPoints = validatedMaximum
		self._hitPoints = validatedHitPoints
		self.hitDice = hitDice
		self.remainingHitDice = remainingHitDice
		self._temporaryHitPoints = max(0, temporaryHitPoints)
		self.deathSaveSuccesses = 0
		self.deathSaveFailures = 0
		self.isStable = validatedHitPoints == 0 && isStableAtZero
	}

	// MARK: - Temporary hit points

	/// Replaces the current temporary hit-point value.
	///
	/// Temporary hit points do not restore consciousness, provide healing,
	/// or affect death-saving throws.
	public func setTemporaryHitPoints(_ amount: Int) {
		_temporaryHitPoints = max(0, amount)
	}

	/// Accepts newly offered temporary hit points only when the new amount
	/// is greater than the current amount.
	///
	/// Temporary hit points do not stack.
	public func gainTemporaryHitPoints(_ amount: Int) {
		_temporaryHitPoints = max(_temporaryHitPoints, amount)
	}

	// MARK: - Maximum hit points and healing

	/// Changes the creature's maximum hit points.
	///
	/// When `restoreToMaximum` is true, a living creature is restored to its
	/// new maximum. This method does not resurrect a dead creature.
	public func setMaximumHitPoints(
		_ amount: Int,
		restoreToMaximum: Bool = false
	) {
		_maxHitPoints = max(1, amount)

		guard !isDead else {
			_hitPoints = 0
			return
		}

		if restoreToMaximum {
			_hitPoints = _maxHitPoints
			resetDeathSaves()

			// Restoring hit points makes the creature conscious, so it is no
			// longer stable at 0 HP.
			isStable = false
		} else {
			_hitPoints = min(_hitPoints, _maxHitPoints)
		}
	}

// on short rest user consumes # of dice for hit points
// on long rest all are restored

	public func shortRest(using: [Die]) -> Int {
		.zero
	}

	public func longRest() {
	}

	public func applyHealing(_ amount: Int) {
		guard amount > 0, !isDead else { return }

		_hitPoints = min(_maxHitPoints, _hitPoints + amount)

		if _hitPoints > 0 {
			resetDeathSaves()

			// Healing above 0 HP makes the creature conscious, so it is no
			// longer stable at 0 HP.
			isStable = false
		}
	}

	// MARK: - Damage

	/// Applies damage after resistance, vulnerability, immunity, and other
	/// damage adjustments have already been calculated.
	///
	/// The caller must determine whether the attack was a critical hit.
	public func applyDamage(
		_ amount: Int,
		isCriticalHit: Bool = false
	) {
		guard amount > 0, !isDead else { return }

		let wasAtZeroHitPoints = _hitPoints == 0

		let absorbedDamage = min(_temporaryHitPoints, amount)
		_temporaryHitPoints -= absorbedDamage

		let remainingDamage = amount - absorbedDamage

		if wasAtZeroHitPoints {
			applyDamageAtZero(
				remainingDamage,
				isCriticalHit: isCriticalHit
			)
			return
		}

		guard remainingDamage > 0 else { return }

		let previousHitPoints = _hitPoints
		_hitPoints = max(0, _hitPoints - remainingDamage)

		guard _hitPoints == 0 else { return }

		// Being reduced to 0 HP begins the dying condition.
		isStable = false

		let excessDamage = remainingDamage - previousHitPoints
		if excessDamage >= _maxHitPoints {
			die()
		}
	}

	private func applyDamageAtZero(
		_ remainingDamage: Int,
		isCriticalHit: Bool
	) {
		// Taking damage while stable at 0 HP ends stability, even when
		// temporary hit points absorb all of the numerical damage.
		isStable = false

		// Only damage remaining after temporary hit points can cause instant
		// death from massive damage.
		if remainingDamage >= _maxHitPoints {
			die()
			return
		}

		addDeathSaveFailures(isCriticalHit ? 2 : 1)
	}

	// MARK: - Death saving throws

	/// Records a death saving throw.
	///
	/// - Parameters:
	///   - dieRoll: The natural d20 result, before modifiers.
	///   - modifier: Any bonus or penalty applied to the saving throw total.
	@discardableResult
	public func rollDeathSave(
		dieRoll: Int,
		modifier: Int = 0
	) -> DeathSaveResult {
		guard (1...deathSaveDie.sides).contains(dieRoll) else {
			return .invalidRoll
		}

		guard needsDeathSavingThrow else {
			return .notRequired
		}

		switch dieRoll {
		case 1:
			addDeathSaveFailures(2)
			return isDead ? .died : .twoFailures

		case deathSaveDie.sides:
			_hitPoints = 1
			resetDeathSaves()

			// A natural 20 restores 1 HP, so the creature becomes conscious
			// and is no longer stable at 0 HP.
			isStable = false

			return .regainedConsciousness

		default:
			if dieRoll + modifier >= deathSaveDie.sides/2 {
				deathSaveSuccesses += 1

				if deathSaveSuccesses >= deathSaveMaximum {
					stabilize()
					return .stabilized
				}

				return .success
			}

			addDeathSaveFailures(1)
			return isDead ? .died : .failure
		}
	}

	/// Stabilizes the creature at 0 HP.
	///
	/// This may represent three successful death saves, a successful
	/// Wisdom (Medicine) check, a healer's kit, or another stabilizing effect.
	public func stabilize() {
		guard _hitPoints == 0, !isDead else { return }

		resetDeathSaves()

		// A stabilized creature remains unconscious at 0 HP but no longer
		// makes death saving throws unless it takes damage.
		isStable = true
	}

	// MARK: - Internal state transitions

	private func addDeathSaveFailures(_ amount: Int) {
		deathSaveFailures = min(
			deathSaveMaximum,
			deathSaveFailures + max(0, amount)
		)

		if isDead {
			die()
		}
	}

	private func die() {
		_hitPoints = 0
		_temporaryHitPoints = 0
		deathSaveSuccesses = 0
		deathSaveFailures = deathSaveMaximum

		// A dead creature cannot also be stable.
		isStable = false
	}

	private func resetDeathSaves() {
		deathSaveSuccesses = 0
		deathSaveFailures = 0
	}
}
