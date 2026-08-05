import Foundation

public enum EquipmentLocation: String, JCSEnum {
	case equipped
	case carried
	case stored
}

public enum AttunementState: String, JCSEnum {
	case notRequired
	case unattuned
	case attuned
}

public struct Equipment: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let location: EquipmentLocation
	public let quantity: Int
	public let unitWeight: Unit<WeightUnit>?
	public let armorContribution: Int?
	public let attunement: AttunementState
	public let charges: ResourceCounter?
	public let isConsumable: Bool
	public let notes: [String]

	public init(
		_ name: String = .init(),
		location: EquipmentLocation = .carried,
		quantity: Int = 1,
		unitWeight: Unit<WeightUnit>? = nil,
		armorContribution: Int? = nil,
		attunement: AttunementState = .notRequired,
		charges: ResourceCounter? = nil,
		isConsumable: Bool = false,
		notes: [String] = []
	) {
		self.name = name
		self.location = location
		self.quantity = max(quantity, 0)
		self.unitWeight = unitWeight.map { .init(max($0.value, 0), $0.kind) }
		self.armorContribution = armorContribution
		self.attunement = attunement
		self.charges = charges
		self.isConsumable = isConsumable
		self.notes = notes
	}

	public init(_ name: String = .init(), counter: ResourceCounter?) {
		self.init(name, charges: counter)
	}

	public var totalWeight: Unit<WeightUnit>? {
		unitWeight.map { .init($0.value * Double(quantity), $0.kind) }
	}

	public var isEmpty: Bool {
		name.isEmpty && quantity == 0 && unitWeight == nil && armorContribution == nil && charges.isEmpty && notes.isEmpty
	}
}
