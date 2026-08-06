import Foundation

public struct Valuable: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // I+P/G — inventory/treasure description
	public let detail: String // I+P/G — inventory/treasure description
	public let itemCount: Int // I — changes through acquisition, sale, use, or loss; range: 0...
	public let currency: Currency? // H/G — valuation denomination
	public let currencyCount: Int // I — changes through acquisition, sale, use, or loss; range: 0...

	public init(
		_ name: String = .init(),
		_ detail: String = .init(),
		itemCount: Int = 1,
		_ currency: Currency? = nil,
		_ currencyCount: Int = 0
	) {
		self.name = name
		self.detail = detail
		self.itemCount = itemCount
		self.currency = currency
		self.currencyCount = currencyCount
	}

	public var hasQuantity: Bool { !(itemCount != 0) || !(currencyCount != 0) }

	public var copperValue: Int? {
		guard let currency else { return nil }
		return itemCount * currencyCount * currency.copperValue
	}

	public var isEmpty: Bool {
		name.isEmpty && detail.isEmpty && currency == nil && currencyCount == 0
	}

	public func invariant() throws {
		try require(itemCount >= 0, \Self.itemCount, "must be at least 0")
		try require(currencyCount >= 0, \Self.currencyCount, "must be at least 0")
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		if currency == nil { try require(currencyCount == 0, \Self.currencyCount, "must be 0 when currency is nil") }
	}
}

extension Valuable: StringPresentable {
	public var description: String {
		"\(name)\(itemCount != 1 ? " (\(itemCount))" : "")\(currency.map{ " \(currencyCount)\($0.abbreviation)"} ?? "")"
	}
}
