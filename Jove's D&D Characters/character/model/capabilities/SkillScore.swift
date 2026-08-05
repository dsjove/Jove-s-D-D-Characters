import Foundation

public enum SkillMark: String, JCSEnum {
	case none = ""
	case proficient = "P"
	case expertise = "E"
}

extension SkillMark {
	public var description: String {
		switch self {
		case .none:       ""
		case .proficient: "Proficient"
		case .expertise:  "Expertise"
		}
	}

	public var abbreviation: String {
		rawValue
	}
}

public enum Skill: String, JCSEnum {
	case acrobatics
	case animalHandling
	case arcana
	case athletics
	case deception
	case history
	case insight
	case intimidation
	case investigation
	case medicine
	case nature
	case perception
	case performance
	case persuasion
	case religion
	case sleightOfHand
	case stealth
	case survival

	public var ability: Ability {
		switch self {
		case .acrobatics:
			.dexterity
		case .animalHandling:
			.wisdom
		case .arcana:
			.intelligence
		case .athletics:
			.strength
		case .deception:
			.charisma
		case .history:
			.intelligence
		case .insight:
			.wisdom
		case .intimidation:
			.charisma
		case .investigation:
			.intelligence
		case .medicine:
			.wisdom
		case .nature:
			.intelligence
		case .perception:
			.wisdom
		case .performance:
			.charisma
		case .persuasion:
			.charisma
		case .religion:
			.intelligence
		case .sleightOfHand:
			.dexterity
		case .stealth:
			.dexterity
		case .survival:
			.wisdom
		}
	}
}

public struct SkillScore: Codable, Sendable, EmptyCheckable {
	public let skill: Skill
	public let modifier: Int
	public let mark: SkillMark

	public init(
		_ skill: Skill,
		modifier: Int = 0,
		mark: SkillMark = .none
	) {
		self.skill = skill
		self.modifier = modifier
		self.mark = mark
	}

	public var isEmpty: Bool {
		modifier == 0 && mark == .none
	}
}
