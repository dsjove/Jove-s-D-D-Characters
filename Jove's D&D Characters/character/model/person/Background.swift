import Foundation

public struct Background: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let organization: String
	public let role: String
	public let clearance: String

	public init(
		_ name: String = .init(),
		organization: String = .init(),
		role: String = .init(),
		clearance: String = .init(),
	) {
		self.name = name
		self.organization = organization
		self.role = role
		self.clearance = clearance
	}

	public var isEmpty: Bool {
		name.isEmpty && organization.isEmpty && role.isEmpty && clearance.isEmpty
	}
}
