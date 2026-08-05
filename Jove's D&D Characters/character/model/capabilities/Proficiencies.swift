import Foundation

public struct Proficiencies: Codable, Sendable, EmptyCheckable {
	public let savingThrows: [Ability]
	public let languages: [String]
	public let tools: [String]
	public let armor: [String]
	public let weapons: [String]
	public let expertise: [String]
	public let other: [DetailedSection]

	public init(
		savingThrows: [Ability] = [],
		languages: [String] = [],
		tools: [String] = [],
		armor: [String] = [],
		weapons: [String] = [],
		expertise: [String] = [],
		other: [DetailedSection] = []
	) {
		self.savingThrows = savingThrows
		self.languages = languages
		self.tools = tools
		self.armor = armor
		self.weapons = weapons
		self.expertise = expertise
		self.other = other
	}

	public var isEmpty: Bool {
		savingThrows.isEmpty && languages.isEmpty && tools.isEmpty && armor.isEmpty && weapons.isEmpty && expertise.isEmpty && other.isEffectivelyEmpty
	}
}
