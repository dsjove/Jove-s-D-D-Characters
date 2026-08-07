import Foundation

public enum CombatStat: String, JCSEnum {
	case armorClass
	case initiative
	case proficiencyBonus
	case passivePerception
	case inspirationCounter
	case unknwown

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
		case .unknwown: "?"
		}
	}
}

public struct CombatScore: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let stat: CombatStat // H — fixed rules key
	public let score: Int? // C/S — usually derived; some counters change in session; range: stat-dependent (AC/PP 0..., PB 2...6, inspiration 0..., initiative any Int)
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

	public func invariant() throws {
		guard let score else { return }
		switch stat {
		case .armorClass, .passivePerception, .inspirationCounter:
			try require(score >= 0, \Self.score, "must be at least 0 for \(stat)")
		case .proficiencyBonus:
			try require((2...6).contains(score), \Self.score, "must be in 2...6 for proficiency bonus")
		case .initiative, .unknwown:
			break
		}
	}
}

