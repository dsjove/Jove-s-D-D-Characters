import Foundation

public struct Possessions: Codable, Sendable, EmptyCheckable {
	public let equipment: [Equipment]
	public let moneys: Moneys
	public let valuables: Valuables
	public let encumbrance: Encumbrance

	public init(
		equipment: [Equipment] = [],
		moneys: Moneys = .init(),
		valuables: Valuables = .init(),
		encumbrance: Encumbrance = .init()
	) {
		self.equipment = equipment
		self.moneys = moneys
		self.valuables = valuables
		self.encumbrance = encumbrance
	}

	public var isEmpty: Bool {
		equipment.isEffectivelyEmpty && moneys.isEmpty && valuables.isEmpty && encumbrance.isEmpty
	}
}
