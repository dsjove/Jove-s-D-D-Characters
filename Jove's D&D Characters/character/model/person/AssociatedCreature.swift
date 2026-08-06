import Foundation

public enum AssociatedCreatureKind: String, JCSEnum {
	case familiar
	case animalCompanion
	case mount
	case summon
	case wildShape
	case other
}

public struct AssociatedStatBlock: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let armorClass: Int? // H/G/C — rules/GM value, sometimes derived; range: 0... when set
	public let health: HealthCounter
	public let abilities: [AbilityScore]
	public let speeds: [MovementSpeed]
	public let attacks: [Attack]
	public let features: [Feature]
	public let notes: [String] // P/G — author or GM notes

	public init(
		armorClass: Int? = nil,
		health: HealthCounter = .init(),
		abilities: [AbilityScore] = [],
		speeds: [MovementSpeed] = [],
		attacks: [Attack] = [],
		features: [Feature] = [],
		notes: [String] = []
	) {
		self.armorClass = armorClass
		self.health = health
		self.abilities = abilities
		self.speeds = speeds
		self.attacks = attacks
		self.features = features
		self.notes = notes
	}

	public var isEmpty: Bool {
		armorClass == nil && health.isEmpty && abilities.isEffectivelyEmpty && speeds.isEffectivelyEmpty && attacks.isEffectivelyEmpty && features.isEffectivelyEmpty && notes.isEmpty
	}

	public func invariant() throws {
		if let armorClass { try require(armorClass >= 0, \Self.armorClass, "must be at least 0 when set") }
		try validate(health, at: \Self.health)
		try validate(abilities, at: \Self.abilities)
		try validate(speeds, at: \Self.speeds)
		try validate(attacks, at: \Self.attacks)
		try validate(features, at: \Self.features)
		try requireUnique(abilities.map(\.ability), \Self.abilities, "must not contain duplicate abilities")
	}
}

public struct AssociatedCreature: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // P/G — player or GM establishes/updates
	public let kind: AssociatedCreatureKind // P/G — player or GM establishes/updates
	public let statBlock: AssociatedStatBlock?
	public let notes: [String] // P/G — player or GM establishes/updates

	public init(
		_ name: String = "",
		kind: AssociatedCreatureKind = .other,
		statBlock: AssociatedStatBlock? = nil,
		notes: [String] = []
	) {
		self.name = name
		self.kind = kind
		self.statBlock = statBlock
		self.notes = notes
	}

	public var isEmpty: Bool { name.isEmpty && statBlock.isEmpty && notes.isEmpty }

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		try validate(statBlock, at: \Self.statBlock)
	}
}
