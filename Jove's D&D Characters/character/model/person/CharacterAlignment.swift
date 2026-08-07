import Foundation

public enum AlignmentAxis: String, JCSEnum {
	case lawful
	case neutral
	case chaotic
}

public extension AlignmentAxis {
	var abbreviation: String {
		rawValue.prefix(1).uppercased()
	}
}

public enum MoralityAxis: String, JCSEnum {
	case good
	case neutral
	case evil
}

extension MoralityAxis {
	public var abbreviation: String {
		rawValue.prefix(1).uppercased()
	}
}

public struct CharacterAlignment: Codable, Sendable, InvariantCheckable {
	public let order: AlignmentAxis // P/G — player choice or campaign adjudication
	public let morality: MoralityAxis // P/G — player choice or campaign adjudication

	public init(
		_ order: AlignmentAxis = .neutral,
		_ morality: MoralityAxis = .neutral
	) {
		self.order = order
		self.morality = morality
	}

	public var isTrueNeutral: Bool {
		order == .neutral && morality == .neutral
	}

	public func invariant() throws {}
}

extension CharacterAlignment: StringPresentable {
	public var description: String {
		if isTrueNeutral {
			"True Neutral"
		} else {
			"\(order.description) / \(morality.description)"
		}
	}

	public var abbreviation: String {
		if isTrueNeutral {
			"N"
		} else {
			"\(order.abbreviation)\(morality.abbreviation)"
		}
	}
}
