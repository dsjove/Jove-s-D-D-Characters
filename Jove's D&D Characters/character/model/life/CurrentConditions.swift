import Foundation

public struct CurrentConditions: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let conditions: [Attack.Condition] // S/G — session state, usually imposed or cleared in play
	public let exhaustion: Int // S/G — session state, usually imposed or cleared in play; range: 0...6
	public let persistentEffects: [String] // S/G — session state, usually imposed or cleared in play
	public let concentration: String? // S/G ? — nil means the character is not concentrating

	public init(
		conditions: [Attack.Condition] = [],
		exhaustion: Int = 0,
		persistentEffects: [String] = [],
		concentration: String? = nil
	) {
		self.conditions = conditions
		self.exhaustion = min(max(exhaustion, 0), 6)
		self.persistentEffects = persistentEffects
		self.concentration = concentration
	}

	public var isEmpty: Bool {
		conditions.isEmpty && exhaustion == 0 && persistentEffects.isEmpty && concentration == nil
	}

	public func invariant() throws {
		try require((0...6).contains(exhaustion), \Self.exhaustion, "must be in 0...6")
		try requireUnique(conditions, \Self.conditions, "must not contain duplicate conditions")
	}
}
