import Foundation

public struct Moneys: Codable, Sendable, EmptyCheckable {
	public let copper: Int
	public let silver: Int
	public let electrum: Int
	public let gold: Int
	public let platinum: Int

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
