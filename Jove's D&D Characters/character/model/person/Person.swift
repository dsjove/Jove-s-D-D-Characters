import Foundation

public struct Person: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let identity: Identity
	public let appearance: Appearance
	public let background: Background
	public let personality: Personality
	public let relationships: [Relationship]
	public let associatedCreatures: [AssociatedCreature]
	public let backstory: DetailedSection

	public init(
		identity: Identity = .init(),
		appearance: Appearance = .init(),
		background: Background = .init(),
		personality: Personality = .init(),
		relationships: [Relationship] = .init(),
		associatedCreatures: [AssociatedCreature] = [],
		backstory: DetailedSection = .init()
	) {
		self.identity = identity
		self.appearance = appearance
		self.background = background
		self.personality = personality
		self.relationships = relationships
		self.backstory = backstory
		self.associatedCreatures = associatedCreatures
	}

	public var isEmpty: Bool {
		identity.isEmpty &&
		appearance.isEmpty &&
		background.isEmpty &&
		personality.isEmpty &&
		relationships.isEffectivelyEmpty &&
		backstory.isEmpty &&
		associatedCreatures.isEffectivelyEmpty
	}

	public func invariant() throws {
		try validate(identity, at: \Self.identity)
		try validate(appearance, at: \Self.appearance)
		try validate(background, at: \Self.background)
		try validate(personality, at: \Self.personality)
		try validate(relationships, at: \Self.relationships)
		try validate(associatedCreatures, at: \Self.associatedCreatures)
		try validate(backstory, at: \Self.backstory)
	}
}
