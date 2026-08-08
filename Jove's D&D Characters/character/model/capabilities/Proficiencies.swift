import Foundation

public struct Proficiencies: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let savingThrows: [Ability] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
	public let languages: [String] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
	public let tools: [String] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
	public let armor: [String] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
	public let weapons: [String] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
	public let expertise: [String] // H+P+A/G ~ — rules/build choices; may change at advancement or by GM grant
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

	public func invariant() throws {
		try validate(other, at: \Self.other)
		try requireUnique(savingThrows, \Self.savingThrows, "must not contain duplicates")
	}
}
