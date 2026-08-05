import Foundation

public struct Maneuver: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let detail: String

	public init(_ name: String = "", detail: String = "") {
		self.name = name
		self.detail = detail
	}

	public var isEmpty: Bool {
		name.isEmpty && detail.isEmpty
	}
}
