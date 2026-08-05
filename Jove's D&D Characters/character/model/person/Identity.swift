import Foundation

public struct Identity: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let ancestry: String
	public let classes: [ClassLevel]
	public let alignment: CharacterAlignment

	public init(
		_ name: String = .init(),
		ancestry: String = .init(),
		classes: [ClassLevel] = .init(),
		alignment: CharacterAlignment = .init()
	) {
		self.name = name
		self.ancestry = ancestry
		self.classes = classes
		self.alignment = alignment
	}

	public var level: Int {
		classes.map(\.level).reduce(0, +)
	}

	public var isEmpty: Bool {
		name.isEmpty && ancestry.isEmpty && classes.isEmpty && alignment.isEmpty
	}
}

extension Identity {
	public var sheetSummary: String {
		[
			ancestry,
			sheetClassesSummary,
			sheetSubclassSummary,
			alignment.description
		].filter({!$0.isEmpty}).joined(separator: "  •  ")
	}

	public var sheetClassesSummary: String  {
		classes.map { "\($0.name) \($0.level)" }.joined(separator: " / ")
	}

	var sheetSubclassSummary: String {
		classes.map(\.specialty).joined(separator: " / ")
	}
}
