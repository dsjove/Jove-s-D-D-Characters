import Foundation

public struct Personality: Codable, Sendable, EmptyCheckable {
	public let traits: [String]
	public let ideals: [String]
	public let bonds: [String]
	public let flaws: [String]
	public let manner: [String]

	public init(
		traits: [String] = .init(),
		ideals: [String] = .init(),
		bonds: [String] = .init(),
		flaws: [String] = .init(),
		manner: [String] = .init()
	) {
		self.traits = traits
		self.ideals = ideals
		self.bonds = bonds
		self.flaws = flaws
		self.manner = manner
	}

	public var isEmpty: Bool {
		traits.isEmpty && ideals.isEmpty && bonds.isEmpty && flaws.isEmpty && manner.isEmpty
	}
}
