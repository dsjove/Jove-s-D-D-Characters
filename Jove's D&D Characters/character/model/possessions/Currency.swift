import Foundation

public enum Currency: String, JCSEnum {
	case copper
	case silver
	case electrum
	case gold
	case platinum

	public var copperValue: Int {
		switch self {
		case .copper:   1
		case .silver:   10
		case .electrum: 50
		case .gold:     100
		case .platinum: 1_000
		}
	}

	public var abbreviation: String {
		switch self {
		case .copper:   "cp"
		case .silver:   "sp"
		case .electrum: "ep"
		case .gold:     "gp"
		case .platinum: "pp"
		}
	}
}
