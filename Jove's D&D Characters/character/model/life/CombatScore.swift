import Foundation

public enum CombatStat: String, JCSEnum {
	case armorClass
	case initiative
	case proficiencyBonus
	case passivePerception
	case inspirationCounter

	var isBonus: Bool {
		switch self {
		case .proficiencyBonus, .inspirationCounter, .initiative:
			true
		default:
			false
		}
	}
}

extension CombatStat {
	public var abbreviation: String {
		switch self {
		case .armorClass:         "AC"
		case .initiative:         "Init"
		case .proficiencyBonus:   "PB"
		case .passivePerception:  "PP"
		case .inspirationCounter: "Inspiration"
		}
	}
}

public struct CombatScore: Codable, Sendable, EmptyCheckable {
	public let stat: CombatStat
	public let score: Int?
	public var isBonus: Bool {stat.isBonus}

	public init(
		_ stat: CombatStat,
		score: Int? = nil
	) {
		self.stat = stat
		self.score = score
	}

	public var isEmpty: Bool {
		score == nil
	}
}

