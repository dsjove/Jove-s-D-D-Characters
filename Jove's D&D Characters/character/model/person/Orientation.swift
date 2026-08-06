public enum BioSex: String, JCSEnum {
	case man
	case woman
	case other

	public var abbreviation: String {
		switch self {
			case .man:
			return "M"
		case .woman:
			return "W"
		case .other:
			return "X"
		}
	}

	var defaultGender: Gender {
		switch self {
		case .man:
			return .male
		case .woman:
			return .female
		case .other:
			return .other
		}
	}
}

public enum Gender: String, JCSEnum {
	case male
	case female
	case other

	public var abbreviation: String {
		switch self {
			case .male:
			return "M"
		case .female:
			return "F"
		case .other:
			return "X"
		}
	}

	var defaultPronouns: Pronouns {
		switch self {
		case .male:
			return .he
		case .female:
			return .she
		case .other:
			return .other
		}
	}
}

public enum Pronouns: String, JCSEnum {
	case he
	case she
	case they
	case other

	public var description: String {
		switch self {
		case .he:
			return "He/Him"
		case .she:
			return "She/Her"
		case .they:
			return "Them/Theirs"
		case .other:
			return "Other"
		}
	}

	public var abbreviation: String {
		switch self {
		case .he:
			return "He"
		case .she:
			return "She"
		case .they:
			return "Them"
		case .other:
			return "Other"
		}
	}
}

public struct Orientation: Codable, Sendable, StringPresentable {
	public let bioSex: BioSex
	public let gender: Gender
	public let pronouns: Pronouns

	public init(
		bioSex: BioSex? = nil,
		gender: Gender? = nil,
		pronouns: Pronouns? = nil
	) {
		let bioSex = bioSex ?? .other
		self.bioSex = bioSex
		let gender = gender ?? bioSex.defaultGender
		self.gender = gender
		self.pronouns = pronouns ?? gender.defaultPronouns
	}

	public var description: String {
		"\(bioSex.description), \(gender.description), \(pronouns.description)"
	}

	public var abbreviation: String {
		"\(bioSex.abbreviation)/\(gender.abbreviation)/\(pronouns.abbreviation)"
	}
}
