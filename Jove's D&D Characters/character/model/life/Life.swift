import Foundation

public struct Life: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let health: HealthCounter
	public let abilities: [AbilityScore]
	public let combat: [CombatScore]
	public let defenses: Defenses
	public let movementAndSenses: MovementAndSenses
	public let currentConditions: CurrentConditions

	public init(
		health: HealthCounter = .init(),
		abilities: [AbilityScore] = Ability.allCases.map { .init($0) },
		combat: [CombatScore] = CombatStat.allCases.map { .init($0) },
		defenses: Defenses = .init(),
		movementAndSenses: MovementAndSenses = .init(),
		currentConditions: CurrentConditions = .init()
	) {
		self.health = health
		self.combat = combat
		self.abilities = abilities
		self.defenses = defenses
		self.movementAndSenses = movementAndSenses
		self.currentConditions = currentConditions
	}

	public var isEmpty: Bool {
		health.isEmpty && abilities.isEffectivelyEmpty && combat.isEffectivelyEmpty && defenses.isEmpty && movementAndSenses.isEmpty && currentConditions.isEmpty
	}

	public func invariant() throws {
		try validate(health, at: \Self.health)
		try validate(abilities, at: \Self.abilities)
		try validate(combat, at: \Self.combat)
		try validate(defenses, at: \Self.defenses)
		try validate(movementAndSenses, at: \Self.movementAndSenses)
		try validate(currentConditions, at: \Self.currentConditions)
		try requireUnique(abilities.map(\.ability), \Self.abilities, "must not contain duplicate abilities")
		try requireUnique(combat.map(\.stat), \Self.combat, "must not contain duplicate combat stats")
	}
}
