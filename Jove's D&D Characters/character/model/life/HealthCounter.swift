import Foundation

public protocol HealthCounterInfo {
	var maxHitPoints: Int? { get }
	var hitPoints: Int? { get }
	var temporaryHitPoints: Int? { get }

	var hitDice: [Dice]? { get }
	var remainingHitDice: [Dice]? { get }

	var deathSaveSuccesses: Int { get }
	var deathSaveFailures: Int { get }

	/// Indicates that the creature is stable at 0 hit points.
	/// A stable creature remains unconscious but does not make death saving
	/// throws. Stability ends when the creature regains hit points, takes
	/// damage, or dies.
	var isStable: Bool { get }
}

public struct HealthCounter: Codable, Sendable, HealthCounterInfo, EmptyCheckable, InvariantCheckable {
	public let maxHitPoints: Int? // H+A+R/C — rules plus advancement; may use a roll or formula; range: 1... when set
	public let hitPoints: Int? // S — changes with damage, healing, and rests; range: 0...maxHitPoints when set
	public let hitDice: [Dice]? // H+A ? — nil means hit-die capacity has not been established; [] means none
	public let remainingHitDice: [Dice]? // S ? — nil means remaining dice are not tracked; [] means all are expended
	public let temporaryHitPoints: Int? // S — granted and consumed during play; range: 0... when set
	public let deathSaveSuccesses: Int // R+S — roll results tracked until reset; range: 0...3
	public let deathSaveFailures: Int // R+S — roll results tracked until reset; range: 0...3
	public let isStable: Bool // S — changes from saves, healing, or stabilization

	public init(
		maxHitPoints: Int? = nil,
		hitPoints: Int? = nil,
		hitDice: [Dice]? = nil,
		remainingHitDice: [Dice]? = nil,
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
		maxHitPoints == nil && hitPoints == nil && hitDice == nil && remainingHitDice == nil && temporaryHitPoints == nil && deathSaveSuccesses == 0 && deathSaveFailures == 0 && !isStable
	}

	public func invariant() throws {
		if let maxHitPoints { try require(maxHitPoints >= 1, \Self.maxHitPoints, "must be at least 1 when set") }
		if let hitPoints {
			try require(hitPoints >= 0, \Self.hitPoints, "must be at least 0 when set")
			if let maxHitPoints { try require(hitPoints <= maxHitPoints, \Self.hitPoints, "must not exceed maxHitPoints") }
		}
		if let temporaryHitPoints { try require(temporaryHitPoints >= 0, \Self.temporaryHitPoints, "must be at least 0 when set") }
		try require((0...3).contains(deathSaveSuccesses), \Self.deathSaveSuccesses, "must be in 0...3")
		try require((0...3).contains(deathSaveFailures), \Self.deathSaveFailures, "must be in 0...3")
		try validate(hitDice, at: \Self.hitDice)
		try validate(remainingHitDice, at: \Self.remainingHitDice)
		if let hitDice, let remainingHitDice {
			try require(remainingHitDice.count <= hitDice.count, \Self.remainingHitDice, "must not contain more dice than hitDice")
		}
		if isStable {
			try require(hitPoints == 0, \Self.isStable, "may be true only when hitPoints is 0")
			try require(deathSaveFailures < 3, \Self.isStable, "may not be true after three death-save failures")
		}
	}
}
