import Foundation

public struct Capabilities: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let attacks: [Attack]
	public let skills: [SkillScore]
	public let features: [Feature]
	public let spellcasting: [Spellcasting]
	public let maneuverSaveDC: Int? // C(H+P+A) ? — nil means no maneuver save DC has been established; range: 1... when set
	public let maneuvers: [Maneuver]
	public let proficiencies: Proficiencies
	public let resources: [ReusableResource]

	public init(
		attacks: [Attack] = .init(),
		skills: [SkillScore] = .init(),
		features: [Feature] = .init(),
		spellcasting: [Spellcasting] = .init(),
		maneuverSaveDC: Int? = nil,
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
		attacks.isEffectivelyEmpty && skills.isEffectivelyEmpty && features.isEffectivelyEmpty && maneuverSaveDC == nil && maneuvers.isEffectivelyEmpty && spellcasting.isEffectivelyEmpty && proficiencies.isEmpty && resources.isEffectivelyEmpty
	}

	public func invariant() throws {
		try validate(attacks, at: \Self.attacks)
		try validate(skills, at: \Self.skills)
		try validate(features, at: \Self.features)
		try validate(spellcasting, at: \Self.spellcasting)
		try validate(maneuvers, at: \Self.maneuvers)
		try validate(proficiencies, at: \Self.proficiencies)
		try validate(resources, at: \Self.resources)
		if let maneuverSaveDC { try require(maneuverSaveDC >= 1, \Self.maneuverSaveDC, "must be at least 1 when set") }
		try requireUnique(skills.map(\.skill), \Self.skills, "must not contain duplicate skills")
	}
}
