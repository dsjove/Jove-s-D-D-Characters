import Foundation

public struct Character: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let person: Person
	public let life: Life
	public let capabilities: Capabilities
	public let possessions: Possessions
	public let advancement: Advancement
	public let notes: CharacterNotes

	public init(
		person: Person = .init(),
		life: Life = .init(),
		capabilities: Capabilities = .init(),
		possessions: Possessions = .init(),
		advancement: Advancement = .init(),
		notes: CharacterNotes = .init()
	) {
		self.person = person
		self.life = life
		self.capabilities = capabilities
		self.possessions = possessions
		self.advancement = advancement
		self.notes = notes
	}

	public var isEmpty: Bool {
		person.isEmpty && life.isEmpty && capabilities.isEmpty && possessions.isEmpty && advancement.isEmpty && notes.isEmpty
	}


	public func invariant() throws {
		try validate(person, at: \Self.person)
		try validate(life, at: \Self.life)
		try validate(capabilities, at: \Self.capabilities)
		try validate(possessions, at: \Self.possessions)
		try validate(advancement, at: \Self.advancement)
		try validate(notes, at: \Self.notes)
	}
}

public enum CharacterInitializationError: Error, Equatable {
	case emptyPlayerName
	case emptyAncestry
	case noClasses
	case noAbilityScores
}

public extension Character {
	init(
// Required for begin sheet creation
		name: String,
		ancestry: String,
		classes: [ClassLevel],
		alignment: CharacterAlignment,
		abilityScores: [AbilityScore],

// Optional begin play fields
		player: String,
		background: Background,
		appearance: Appearance = .init(),
		personality: Personality = .init(),
		relationships: [Relationship] = [],
		associatedCreatures: [AssociatedCreature] = [],
		backstory: DetailedSection = .init(),
		skills: [SkillScore] = [],
		attacks: [Attack] = [],
		features: [Feature] = [],
		spellcasting: [Spellcasting] = [],
		maneuvers: [Maneuver] = [],
		proficiencies: Proficiencies = .init(),
		resources: [ReusableResource] = [],
		equipment: [Equipment] = [],
		moneys: Moneys = .init(),
		valuables: Valuables = .init(),
		advancementMethod: AdvancementMethod? = nil,
		notes: CharacterNotes = .init()
	) throws {
		guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
			throw CharacterInitializationError.emptyPlayerName
		}

		guard !ancestry.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
			throw CharacterInitializationError.emptyAncestry
		}

		guard !classes.isEmpty else {
			throw CharacterInitializationError.noClasses
		}

		guard !abilityScores.isEmpty else {
			throw CharacterInitializationError.noAbilityScores
		}

		self.init(
			person: .init(
				identity: .init(
					name,
					player: player,
					ancestry: ancestry,
					classes: classes,
					alignment: alignment
				),
				appearance: appearance,
				background: background,
				personality: personality,
				relationships: relationships,
				associatedCreatures: associatedCreatures,
				backstory: backstory
			),
			life: .init(abilities: abilityScores),
			capabilities: .init(
				attacks: attacks,
				skills: skills,
				features: features,
				spellcasting: spellcasting,
				maneuvers: maneuvers,
				proficiencies: proficiencies,
				resources: resources
			),
			possessions: .init(
				equipment: equipment,
				moneys: moneys,
				valuables: valuables
			),
			advancement: .init(method: advancementMethod),
			notes: notes
		)
	}
}
