import Foundation

public struct Relationship: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let role: String
	public let detail: String

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
}
