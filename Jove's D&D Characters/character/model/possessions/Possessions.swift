import Foundation

public struct Possessions: Codable, Sendable, EmptyCheckable, InvariantCheckable {
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

	public func invariant() throws {
		try validate(equipment, at: \Self.equipment)
		try validate(moneys, at: \Self.moneys)
		try validate(valuables, at: \Self.valuables)
		try validate(encumbrance, at: \Self.encumbrance)
	}
}
