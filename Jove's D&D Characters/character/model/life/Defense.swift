import Foundation

public struct Defenses: Codable, Sendable, EmptyCheckable {
	public let damageResistances: [Attack.DamageType]
	public let vulnerabilities: [Attack.DamageType]
	public let damageImmunities: [Attack.DamageType]
	public let conditionImmunities: [Attack.Condition]
	public let notes: [String]

	public init(
		damageResistances: [Attack.DamageType] = [],
		vulnerabilities: [Attack.DamageType] = [],
		damageImmunities: [Attack.DamageType] = [],
		conditionImmunities: [Attack.Condition] = [],
		notes: [String] = []
	) {
		self.damageResistances = damageResistances
		self.vulnerabilities = vulnerabilities
		self.damageImmunities = damageImmunities
		self.conditionImmunities = conditionImmunities
		self.notes = notes
	}

	public var isEmpty: Bool {
		damageResistances.isEmpty && vulnerabilities.isEmpty && damageImmunities.isEmpty && conditionImmunities.isEmpty && notes.isEmpty
	}
}
