import Foundation

public struct Valuable: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let detail: String
	public let itemCount: Int
	public let currency: Currency?
	public let currencyCount: Int

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
}

extension Valuable: StringPresentable {
	public var description: String {
		"\(name)\(itemCount != 1 ? " (\(itemCount))" : "")\(currency.map{ " \(currencyCount)\($0.abbreviation)"} ?? "")"
	}
}
