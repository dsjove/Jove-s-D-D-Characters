import Foundation

public enum CharacterSize: String, JCSEnum {
	case tiny, small, medium, large, huge, gargantuan
}

public enum CreatureType: String, JCSEnum {
	case aberration, beast, celestial, construct, dragon, elemental, fey, fiend, giant, humanoid, monstrosity, ooze, plant, undead, other
}

public struct Identity: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // P ! — player-authored identity
	public let player: String // P ~ — optional player name
	public let orientation: Orientation? // P ? — nil means not established
	public let ancestry: String // H+P/G ! — rules option, player or GM selected
	public let creatureType: CreatureType? // H+P/G ? — nil means not established
	public let size: CharacterSize? // H+P/G ? — nil means not established
	public let classes: [ClassLevel] // H+P+A ! — at least one class for a ready-to-play character
	public let alignment: CharacterAlignment? // P/G ? — nil means not established

	public init(
		_ name: String = .init(),
		player: String = .init(),
		orientation: Orientation? = nil,
		ancestry: String = .init(),
		creatureType: CreatureType? = nil,
		size: CharacterSize? = nil,
		classes: [ClassLevel] = .init(),
		alignment: CharacterAlignment? = nil
	) {
		self.name = name
		self.player = player
		self.orientation = orientation
		self.ancestry = ancestry
		self.creatureType = creatureType
		self.size = size
		self.classes = classes
		self.alignment = alignment
	}

	public var level: Int {
		classes.compactMap(\.level).reduce(0, +)
	}

	public var isEmpty: Bool {
		name.isEmpty &&
		player.isEmpty &&
		orientation == nil &&
		ancestry.isEmpty &&
		creatureType == nil &&
		size == nil &&
		classes.isEmpty &&
		alignment == nil
	}

	public func invariant() throws {
		guard !isEmpty else { return }
		if !name.isEmpty { try requireMeaningful(name, \Self.name) }
		if !ancestry.isEmpty { try requireMeaningful(ancestry, \Self.ancestry) }
		try validate(classes, at: \Self.classes)
	}
}

extension Identity {
	public var sheetSummary: String {
		[
			ancestry,
			sheetClassesSummary,
			sheetSubclassSummary,
			creatureType?.description,
			size?.description,
			alignment?.description
		].compactMap { $0 }.filter({!$0.isEmpty}).joined(separator: "  •  ")
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
