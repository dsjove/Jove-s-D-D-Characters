import Foundation

public struct Capabilities: Codable, Sendable, EmptyCheckable {
	public let attacks: [Attack]
	public let skills: [SkillScore]
	public let features: [Feature]
	public let spellcasting: [Spellcasting]
	public let maneuvers: [Maneuver]
	public let proficiencies: Proficiencies
	public let resources: [ReusableResource]

	public init(
		attacks: [Attack] = .init(),
		skills: [SkillScore] = .init(),
		features: [Feature] = .init(),
		spellcasting: [Spellcasting] = .init(),
		maneuvers: [Maneuver] = .init(),
		proficiencies: Proficiencies = .init(),
		resources: [ReusableResource] = .init()
	) {
		self.attacks = attacks
		self.skills = skills
		self.features = features
		self.spellcasting = spellcasting
		self.maneuvers = maneuvers
		self.proficiencies = proficiencies
		self.resources = resources
	}

	public var isEmpty: Bool {
		attacks.isEffectivelyEmpty && skills.isEffectivelyEmpty && features.isEffectivelyEmpty && maneuvers.isEffectivelyEmpty && spellcasting.isEffectivelyEmpty && proficiencies.isEmpty && resources.isEffectivelyEmpty
	}
}
