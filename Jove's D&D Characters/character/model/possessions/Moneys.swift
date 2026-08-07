import Foundation

public struct Moneys: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let copper: Int // I — changes through purchases, rewards, and loss; range: 0...
	public let silver: Int // I — changes through purchases, rewards, and loss; range: 0...
	public let electrum: Int // I — changes through purchases, rewards, and loss; range: 0...
	public let gold: Int // I — changes through purchases, rewards, and loss; range: 0...
	public let platinum: Int // I — changes through purchases, rewards, and loss; range: 0...
	//TODO: debt

	public init(
		copper: Int = 0,
		silver: Int = 0,
		electrum: Int = 0,
		gold: Int = 0,
		platinum: Int = 0
	) {
		self.copper = copper
		self.silver = silver
		self.electrum = electrum
		self.gold = gold
		self.platinum = platinum
	}

	public var copperValue: Int {
		copper * Currency.copper.copperValue +
		silver * Currency.silver.copperValue +
		electrum * Currency.electrum.copperValue +
		gold * Currency.gold.copperValue +
		platinum * Currency.platinum.copperValue
	}

	public var isEmpty: Bool {
		copperValue == 0
	}

	public var values: [Currency: Int] {
		[
			.copper: copper,
			.silver: silver,
			.electrum: electrum,
			.gold: gold,
			.platinum: platinum,
		]
	}

	public func invariant() throws {
		try require(copper >= 0, \Self.copper, "must be at least 0")
		try require(silver >= 0, \Self.silver, "must be at least 0")
		try require(electrum >= 0, \Self.electrum, "must be at least 0")
		try require(gold >= 0, \Self.gold, "must be at least 0")
		try require(platinum >= 0, \Self.platinum, "must be at least 0")
	}
}

extension Moneys: StringPresentable {
	public var description: String {
		guard copperValue != 0 else { return "0 \(Currency.copper.abbreviation)" }
		let parts: [String] = [
			copper == 0 ? nil : "\(copper)\(Currency.copper.abbreviation)",
			silver == 0 ? nil : "\(silver)\(Currency.silver.abbreviation)",
			electrum == 0 ? nil : "\(electrum)\(Currency.electrum.abbreviation)",
			gold == 0 ? nil : "\(gold)\(Currency.gold.abbreviation)",
			platinum == 0 ? nil : "\(platinum)\(Currency.platinum.abbreviation)",
		].compactMap({$0})
		return parts.joined(separator: " ")
	}

	public var abbreviation: String {
		"\(copperValue)\(Currency.copper.abbreviation)"
	}
}
