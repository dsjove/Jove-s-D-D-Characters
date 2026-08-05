import Foundation

public enum Ability: String, JCSEnum {
	case strength = "STR"
	case dexterity = "DEX"
	case constitution = "CON"
	case intelligence = "INT"
	case wisdom = "WIS"
	case charisma = "CHA"
}

extension Ability {
	public var description: String {
		switch self {
		case .strength:     "Strength"
		case .dexterity:    "Dexterity"
		case .constitution: "Constitution"
		case .intelligence: "Intelligence"
		case .wisdom:       "Wisdom"
		case .charisma:     "Charisma"
		}
	}

	public var abbreviation: String {
		rawValue
	}
}

public struct AbilityScore: Codable, Sendable, EmptyCheckable {
	public let ability: Ability
	public let score: Int
	public let modifier: Int
	public let savingThrow: Int

	public init(_ ability: Ability = .strength, score: Int = 0, modifier: Int = 0, savingThrow: Int = 0) {
		self.ability = ability
		self.score = score
		self.modifier = modifier
		self.savingThrow = savingThrow
	}

	public var isEmpty: Bool {
		score == 0 && modifier == 0 && savingThrow == 0
	}
}

extension AbilityScore {
	public var sheetModMultiLineDescription: String {
		"Mod \(modifier.signedDescription())\nSave \(savingThrow.signedDescription())"
	}
}
