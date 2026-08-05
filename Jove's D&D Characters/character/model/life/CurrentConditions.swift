import Foundation

public struct CurrentConditions: Codable, Sendable, EmptyCheckable {
	public let conditions: [Attack.Condition]
	public let exhaustion: Int
	public let persistentEffects: [String]
	public let concentration: String?

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
}
