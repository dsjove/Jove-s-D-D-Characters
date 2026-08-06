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

public struct Equipment: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // I+P/G — inventory entry from player or GM
	public let location: EquipmentLocation // I+S — changes with inventory/loadout or use
	public let quantity: Int // I+S — changes with inventory/loadout or use; range: 0...
	public let unitWeight: Unit<WeightUnit>? // H/G — item rule or GM definition
	public let armorContribution: Int? // H/G — item rule or GM definition; range: any Int when set
	public let attunement: AttunementState // I+S — changes with inventory/loadout or use
	public let charges: ResourceCounter?
	public let isConsumable: Bool // H/G — item rule or GM definition
	public let notes: [String] // I+P/G — inventory entry from player or GM

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

	public func invariant() throws {
		try require(quantity >= 0, \Self.quantity, "must be at least 0")
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		if let unitWeight { try require(unitWeight.value.isFinite && unitWeight.value >= 0, \Self.unitWeight, "must be finite and at least 0") }
		try validate(charges, at: \Self.charges)
		if attunement == .attuned { try require(quantity > 0, \Self.attunement, "cannot be attuned when quantity is 0") }
	}
}
