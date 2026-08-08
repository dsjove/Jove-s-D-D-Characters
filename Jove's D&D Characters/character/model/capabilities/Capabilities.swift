import Foundation

public struct Capabilities: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let attacks: [Attack]
	public let skills: [SkillScore]
	public let features: [Feature]
	public let spellcasting: [Spellcasting]
	public let maneuverSaveDC: Int?
	public let maneuvers: [Maneuver]
	public let proficiencies: Proficiencies
	public let resources: [ReusableResource]

	public init(
		attacks: [Attack] = .init(),
		skills: [SkillScore] = .init(),
		features: [Feature] = .init(),
		spellcasting: [Spellcasting] = .init(),
		maneuverSaveDC: Int? = .init(),
		maneuvers: [Maneuver] = .init(),
		proficiencies: Proficiencies = .init(),
		resources: [ReusableResource] = .init()
	) {
		self.attacks = attacks
		self.skills = skills
		self.features = features
		self.spellcasting = spellcasting
		self.maneuverSaveDC = maneuverSaveDC
		self.maneuvers = maneuvers
		self.proficiencies = proficiencies
		self.resources = resources
	}

	public var isEmpty: Bool {
		attacks.isEffectivelyEmpty && skills.isEffectivelyEmpty && features.isEffectivelyEmpty && maneuvers.isEffectivelyEmpty && spellcasting.isEffectivelyEmpty && proficiencies.isEmpty && resources.isEffectivelyEmpty
	}

	public func invariant() throws {
		try validate(attacks, at: \Self.attacks)
		try validate(skills, at: \Self.skills)
		try validate(features, at: \Self.features)
		try validate(spellcasting, at: \Self.spellcasting)
		try validate(maneuvers, at: \Self.maneuvers)
		try validate(proficiencies, at: \Self.proficiencies)
		try validate(resources, at: \Self.resources)
		try requireUnique(skills.map(\.skill), \Self.skills, "must not contain duplicate skills")
	}
}
