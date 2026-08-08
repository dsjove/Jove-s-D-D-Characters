import Foundation

public struct Maneuver: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P+A/G ! — rules option selected or custom content
	public let detail: String // H+P+A/G ~ — rules option selected or custom content

	public init(_ name: String = "", detail: String = "") {
		self.name = name
		self.detail = detail
	}

	public var isEmpty: Bool {
		name.isEmpty && detail.isEmpty
	}

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
	}
}
