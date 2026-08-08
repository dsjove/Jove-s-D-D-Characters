import Foundation

public struct Relationship: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // P/G ! — player-authored; may evolve through campaign
	public let role: String // P/G ~ — player-authored; may evolve through campaign
	public let detail: String // P/G ~ — player-authored; may evolve through campaign

	public init(
		_ name: String = .init(),
		role: String = .init(),
		detail: String = .init()
	) {
		self.name = name
		self.role = role
		self.detail = detail
	}

	public var isEmpty: Bool {
		name.isEmpty && role.isEmpty && detail.isEmpty
	}

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
	}
}
