import Foundation

public struct ClassLevel: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P — rules option selected by player
	public let specialty: String? // H+P ? — nil means the specialty has not been established
	public let level: Int? // A ? — nil means the level has not been established; range: 1...20 when set

	public init(
		_ name: String = .init(),
		specialty: String? = nil,
		level: Int? = nil
	) {
		self.name = name
		self.specialty = specialty
		self.level = level
	}

	public var isEmpty: Bool {
		name.isEmpty && specialty == nil && level == nil
	}

	public func invariant() throws {
		try requireMeaningful(name, \Self.name)
		if let level { try require((1...20).contains(level), \Self.level, "must be in 1...20 when set") }
	}
}
