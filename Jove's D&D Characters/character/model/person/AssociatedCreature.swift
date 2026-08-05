import Foundation

public enum AssociatedCreatureKind: String, JCSEnum {
	case familiar
	case animalCompanion
	case mount
	case summon
	case wildShape
	case other
}

public struct AssociatedStatBlock: Codable, Sendable, EmptyCheckable {
	public let armorClass: Int?
	public let health: HealthCounter
	public let abilities: [AbilityScore]
	public let speeds: [MovementSpeed]
	public let attacks: [Attack]
	public let features: [Feature]
	public let notes: [String]

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
}

public struct AssociatedCreature: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let kind: AssociatedCreatureKind
	public let statBlock: AssociatedStatBlock?
	public let notes: [String]

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
}
