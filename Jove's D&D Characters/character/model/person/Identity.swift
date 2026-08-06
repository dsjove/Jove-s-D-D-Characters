import Foundation

public struct Identity: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // P — player-authored identity
	public let player: String // P — player-authored identity
	public let orientation: Orientation
	public let ancestry: String // H+P/G — rules option, player or GM selected
	public let classes: [ClassLevel]
	public let alignment: CharacterAlignment

	public init(
		_ name: String = .init(),
		player: String = .init(),
		orientation: Orientation = .init(),
		ancestry: String = .init(),
		classes: [ClassLevel] = .init(),
		alignment: CharacterAlignment = .init()
	) {
		self.name = name
		self.player = player
		self.orientation = orientation
		self.ancestry = ancestry
		self.classes = classes
		self.alignment = alignment
	}

	public var level: Int {
		classes.compactMap(\.level).reduce(0, +)
	}

	public var isEmpty: Bool {
		name.isEmpty && ancestry.isEmpty && classes.isEmpty && alignment.isEmpty
	}

	public func invariant() throws {
		try requireMeaningful(name, \Self.name)
		try requireMeaningful(ancestry, \Self.ancestry)
		try require(!classes.isEmpty, \Self.classes, "must contain at least one class")
		try validate(classes, at: \Self.classes)
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
		classes.map { classLevel in
			[classLevel.name, classLevel.level?.description]
				.compactMap { $0 }
				.filter { !$0.isEmpty }
				.joined(separator: " ")
		}.joined(separator: " / ")
	}

	var sheetSubclassSummary: String {
		classes.compactMap(\.specialty).joined(separator: " / ")
	}
}
