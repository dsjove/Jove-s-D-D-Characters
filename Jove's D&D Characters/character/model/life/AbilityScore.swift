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

public struct AbilityScore: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public static let die = Die.d20

	public let ability: Ability // H — fixed rules key
	public let score: Int? // P/R+A ? — nil means not established; range: 1...30 when set
	public let modifier: Int? // C(score) ? — nil means not yet derived; range: -5...10 when set
	public let savingThrow: Int? // C(score+H+A) ? — nil means not yet derived; range: any Int when set

	public init(_ ability: Ability = .strength, score: Int? = nil, modifier: Int? = nil, savingThrow: Int? = nil) {
		self.ability = ability
		self.score = score
		self.modifier = modifier
		self.savingThrow = savingThrow
	}

	public var isEmpty: Bool {
		score == nil && modifier == nil && savingThrow == nil
	}

	public func invariant() throws {
		if let score { try require((1...30).contains(score), \Self.score, "must be in 1...30 when set") }
		if let modifier { try require((-5...10).contains(modifier), \Self.modifier, "must be in -5...10 when set") }
		if let score, let modifier {
			try require(modifier == Int(floor(Double(score - 10) / 2.0)), \Self.modifier, "must equal the modifier derived from score")
		}
	}

	public static func rollAbilities() -> [Int] {
		(0..<6)
			.map { _ in
				(0..<4)
					.map { _ in Die.d6.roll() }
					.sorted()
					.dropFirst()
					.reduce(0, +)
			}
			.sorted(by: >)
	}
}

extension AbilityScore {
	public var sheetModMultiLineDescription: String {
		"Mod \(modifier?.signedDescription() ?? "")\nSave \(savingThrow?.signedDescription() ?? "")"
	}
}
