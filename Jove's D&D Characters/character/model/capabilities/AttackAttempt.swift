import Foundation

public struct AttackAttempt: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public static let attackDie = Attack.attackDie
	public let attack: Attack
	public let rollMode: RollMode // S/G — set for the current attempt/situation
	public let cover: Cover // S/G — set for the current attempt/situation
	public let targetArmorClass: Int? // S/G — set for the current attempt/situation; range: 0... when set
	public let situationalAttackModifier: Int // S/G — set for the current attempt/situation; range: any Int
	public let rolls: [Int] // R — direct die-roll input/result; each value: 1...20
	public let selectedDie: Int? // R — direct die-roll input/result; range: 1...20 when set
	public let attackTotal: Int? // C(R+H+S) — computed from roll, attack data, and situation; range: any Int when set
	public let outcome: Outcome // C(R+H+S) — computed from roll, attack data, and situation

	public init(
		_ attack: Attack = .init(),
		rollMode: RollMode = .normal,
		cover: Cover = .none,
		targetArmorClass: Int? = nil,
		situationalAttackModifier: Int = 0,
		rolls: [Int] = [],
		selectedDie: Int? = nil,
		attackTotal: Int? = nil,
		outcome: Outcome = .unresolved
	) {
		self.attack = attack
		self.rollMode = rollMode
		self.cover = cover
		self.targetArmorClass = targetArmorClass.map { max(0, $0) }
		self.situationalAttackModifier = situationalAttackModifier
		self.rolls = rolls.map { min(max($0, 1), Self.attackDie.sides) }
		self.selectedDie = selectedDie.map { min(max($0, 1), Self.attackDie.sides) }
		self.attackTotal = attackTotal
		self.outcome = outcome
	}

	public var effectiveArmorClass: Int? {
		targetArmorClass.map { $0 + cover.armorClassBonus }
	}

	public var isEmpty: Bool {
		attack.isEmpty && targetArmorClass == nil && situationalAttackModifier == 0 && rolls.isEmpty && selectedDie == nil && attackTotal == nil && outcome == .unresolved
	}

	public func invariant() throws {
		try validate(attack, at: \Self.attack)
		if let targetArmorClass { try require(targetArmorClass >= 0, \Self.targetArmorClass, "must be at least 0 when set") }
		for (index, roll) in rolls.enumerated() {
			try require((1...Self.attackDie.sides).contains(roll), InvariantPath(\Self.rolls).appending(index: index), "must be in 1...\(Self.attackDie.sides)")
		}
		if let selectedDie {
			try require((1...Self.attackDie.sides).contains(selectedDie), \Self.selectedDie, "must be in 1...\(Self.attackDie.sides)")
			try require(rolls.contains(selectedDie), \Self.selectedDie, "must be one of rolls")
		}
		switch rollMode {
		case .normal:
			try require(rolls.count <= 1, \Self.rolls, "may contain at most one roll in normal mode")
		case .advantage, .disadvantage:
			try require(rolls.count <= 2, \Self.rolls, "may contain at most two rolls in advantage/disadvantage mode")
		}
		if let attackTotal, let selectedDie {
			let expected = selectedDie + (attack.attackBonus ?? 0) + situationalAttackModifier
			try require(attackTotal == expected, \Self.attackTotal, "must equal selectedDie + attackBonus + situationalAttackModifier")
		}
	}
}

public extension AttackAttempt {
	enum RollMode: String, JCSEnum {
		case normal
		case advantage
		case disadvantage
	}

	enum Cover: String, JCSEnum {
		case none
		case half
		case threeQuarters
		case total

		public var armorClassBonus: Int {
			switch self {
			case .none, .total:
				0
			case .half:
				2
			case .threeQuarters:
				5
			}
		}

		public var preventsDirectTargeting: Bool {
			self == .total
		}
	}

	enum Outcome: String, JCSEnum {
		case unresolved
		case invalidTarget
		case miss
		case hit
		case criticalHit
		case criticalMiss
	}
}
