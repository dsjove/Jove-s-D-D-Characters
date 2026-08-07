import Foundation

public enum Recharge: String, JCSEnum {
	case shortRest
	case longRest
	case turnOrRound
	case dawn
	case oncePerDay
}

public struct ResourceCounter: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let recharge: Recharge? // H+A/G — rules/level or GM-defined limit
	public let maximum: Int? // H+A/G — rules/level or GM-defined limit; range: 0... when set
	public let used: Int // S — changes during play; resets per recharge; range: 0...maximum, or 0... when maximum is unset
	public let suffix: String // P/H — display text from rules or author

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


	public func invariant() throws {
		if let maximum { try require(maximum >= 0, \Self.maximum, "must be at least 0 when set") }
		try require(used >= 0, \Self.used, "must be at least 0")
		if let maximum { try require(used <= maximum, \Self.used, "must not exceed maximum") }
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
			return "\(filled)\(empty)\(suffix.isEmpty ? "" : " \(suffix)")"
		}
		return "\(used) of \(maximum)\(suffix.isEmpty ? "" : " \(suffix)")"
	}

	public var description: String {
		"\(sheetUsageDescription)\(recharge.map { " @\($0.description)" } ?? "")"
	}
}
