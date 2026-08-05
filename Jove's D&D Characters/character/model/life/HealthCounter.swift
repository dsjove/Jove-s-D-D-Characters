import Foundation

public protocol HealthCounterInfo {
	var maxHitPoints: Int? { get }
	var hitPoints: Int? { get }
	var temporaryHitPoints: Int? { get }

	var hitDice: [Dice] { get }
	var remainingHitDice: [Dice] { get }

	var deathSaveSuccesses: Int { get }
	var deathSaveFailures: Int { get }

	/// Indicates that the creature is stable at 0 hit points.
	/// A stable creature remains unconscious but does not make death saving
	/// throws. Stability ends when the creature regains hit points, takes
	/// damage, or dies.
	var isStable: Bool { get }
}

public struct HealthCounter: Codable, Sendable, HealthCounterInfo, EmptyCheckable {
	public let maxHitPoints: Int?
	public let hitPoints: Int?
	public let hitDice: [Dice]
	public let remainingHitDice: [Dice]
	public let temporaryHitPoints: Int?
	public let deathSaveSuccesses: Int
	public let deathSaveFailures: Int
	public let isStable: Bool

	public init(
		maxHitPoints: Int? = nil,
		hitPoints: Int? = nil,
		hitDice: [Dice] = [],
		remainingHitDice: [Dice] = [],
		temporaryHitPoints: Int? = nil,
		deathSaveSuccesses: Int = 0,
		deathSaveFailures: Int = 0,
		isStable: Bool = false
	) {
		self.maxHitPoints = maxHitPoints
		self.hitPoints = hitPoints
		self.hitDice = hitDice
		self.remainingHitDice = remainingHitDice
		self.temporaryHitPoints = temporaryHitPoints
		self.deathSaveSuccesses = deathSaveSuccesses
		self.deathSaveFailures = deathSaveFailures
		self.isStable = isStable
	}

	public var isEmpty: Bool {
		maxHitPoints == nil && hitPoints == nil && hitDice.isEffectivelyEmpty && remainingHitDice.isEffectivelyEmpty && temporaryHitPoints == nil && deathSaveSuccesses == 0 && deathSaveFailures == 0 && !isStable
	}
}
