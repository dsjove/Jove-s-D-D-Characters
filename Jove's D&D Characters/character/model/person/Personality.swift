import Foundation

public struct Personality: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let traits: [String] // P/G ~ — player-authored; may evolve through campaign
	public let ideals: [String] // P/G ~ — player-authored; may evolve through campaign
	public let bonds: [String] // P/G ~ — player-authored; may evolve through campaign
	public let flaws: [String] // P/G ~ — player-authored; may evolve through campaign
	public let manner: [String] // P/G ~ — player-authored; may evolve through campaign

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

	public func invariant() throws {}
}
