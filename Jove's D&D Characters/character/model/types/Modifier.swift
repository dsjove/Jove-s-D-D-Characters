import Foundation

public extension Int {
	func signedDescription(apply: Bool = true, zero: Bool = true) -> String {
		if apply && ((zero && self == 0) || (self > 0)) {
			"+\(self)"
		} else {
			"\(self)"
		}
	}

	var modifierDescription: String {
		switch self {
		case let value where value > 0:
			"+ \(value)"
		case let value where value < 0:
			"- \(abs(value))"
		default:
			""
		}
	}
}
