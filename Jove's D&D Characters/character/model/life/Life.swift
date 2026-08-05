import Foundation

public struct Life: Codable, Sendable, EmptyCheckable {
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
}
