import Foundation

public struct Background: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P/G ~ — rules template plus player/GM detail
	public let organization: String // H+P/G ~ — rules template plus player/GM detail
	public let role: String // H+P/G ~ — rules template plus player/GM detail
	public let clearance: String // H+P/G ~ — rules template plus player/GM detail

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

	public func invariant() throws {}
}
