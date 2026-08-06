import Foundation

public struct Defenses: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let damageResistances: [Attack.DamageType] // H+P/G+S — rules/choices; active effects may change in play
	public let vulnerabilities: [Attack.DamageType] // H+P/G+S — rules/choices; active effects may change in play
	public let damageImmunities: [Attack.DamageType] // H+P/G+S — rules/choices; active effects may change in play
	public let conditionImmunities: [Attack.Condition] // H+P/G+S — rules/choices; active effects may change in play
	public let notes: [String] // H+P/G+S — rules/choices; active effects may change in play

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

	public func invariant() throws {
		try require(Set(damageResistances).isDisjoint(with: Set(vulnerabilities)), \Self.damageResistances, "must not overlap vulnerabilities")
		try require(Set(damageImmunities).isDisjoint(with: Set(vulnerabilities)), \Self.damageImmunities, "must not overlap vulnerabilities")
	}
}
