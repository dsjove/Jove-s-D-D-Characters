import Foundation

public enum Recharge: String, JCSEnum {
	case shortRest
	case longRest
	case turnOrRound
	case dawn
	case oncePerDay
}

public struct ResourceCounter: Codable, Sendable, EmptyCheckable {
	public let recharge: Recharge?
	public let maximum: Int?
	public let used: Int
	public let suffix: String

	public init(
		recharge: Recharge? = nil,
		maximum: Int? = 1,
		used: Int = 0,
		suffix: String = ""
	) {
		let maximum = maximum.map { max($0, 0) }
		self.maximum = maximum
		self.used = min(max(used, 0), maximum ?? Int.max)
		self.recharge = recharge
		self.suffix = suffix
	}

	public var remaining: Int? {
		maximum.map { max($0 - used, 0) }
	}

	public var isEmpty: Bool {
		recharge == nil && maximum == nil && used == 0 && suffix.isEmpty
	}
}

extension ResourceCounter: StringPresentable {
	public var sheetUsageDescription: String {
		guard let maximum else {
			return "\(used) (unlimited) \(suffix)"
		}
		if maximum <= 5 {
			let filled = String(repeating: "●", count: used)
			let empty = String(repeating: "○", count: maximum - used)
			return "\(filled)\(empty) \(suffix)"
		}
		return "\(used) of \(maximum) \(suffix)"
	}

	public var description: String {
		"\(sheetUsageDescription)\(recharge.map { " @\($0.description)" } ?? "")"
	}
}
