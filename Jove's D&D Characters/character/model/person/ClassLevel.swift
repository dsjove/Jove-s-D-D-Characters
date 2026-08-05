import Foundation

public struct ClassLevel: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let specialty: String
	public let level: Int

	public init(
		_ name: String = .init(),
		specialty: String = .init(),
		level: Int = 0
	) {
		self.name = name
		self.specialty = specialty
		self.level = level
	}

	public var isEmpty: Bool {
		name.isEmpty && specialty.isEmpty && level == 0
	}
}
