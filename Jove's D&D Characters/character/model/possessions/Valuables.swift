import Foundation

public struct Valuables: Codable, Sendable, EmptyCheckable {
	public let items: [Valuable]

	public init(_ items: [Valuable] = []) {
		self.items = items
	}

	public var totalCopperValue: Int {
		items.reduce(0) { $0 + ($1.copperValue ?? 0) }
	}

	public var isEmpty: Bool {
		items.isEffectivelyEmpty
	}
}

extension Valuables: StringPresentable {
	public var description: String {
		guard !items.isEmpty else { return "0 \(Currency.copper.abbreviation)" }
		let parts = items.compactMap {
			$0.hasQuantity ? $0.description : nil
		}
		return parts.joined(separator: ", ")
	}
}
