import Foundation

public enum EncumbranceState: String, JCSEnum {
	case unencumbered
	case encumbered
	case heavilyEncumbered
	case overloaded
}

public struct Encumbrance: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let carryingCapacity: Unit<WeightUnit>? // C(H+P+A+S) — derived from rules, ability, size, and effects
	public let carriedWeight: Unit<WeightUnit>? // C(I+H+S) — derived from inventory, rules, and active effects
	public let state: EncumbranceState? // C(I+H+S) — derived from inventory, rules, and active effects

	public init(carryingCapacity: Unit<WeightUnit>? = nil, carriedWeight: Unit<WeightUnit>? = nil, state: EncumbranceState? = nil) {
		self.carryingCapacity = carryingCapacity.map { .init(max($0.value, 0), $0.kind) }
		self.carriedWeight = carriedWeight.map { .init(max($0.value, 0), $0.kind) }
		self.state = state
	}

	public var isEmpty: Bool { carryingCapacity == nil && carriedWeight == nil && state == nil }

	public func invariant() throws {
		if let carryingCapacity { try require(carryingCapacity.value.isFinite && carryingCapacity.value >= 0, \Self.carryingCapacity, "must be finite and at least 0") }
		if let carriedWeight { try require(carriedWeight.value.isFinite && carriedWeight.value >= 0, \Self.carriedWeight, "must be finite and at least 0") }
	}

	var description: String {
		if let state {
			if let carriedWeight {
				if let carryingCapacity {
					"Carrying \(carriedWeight) of \(carryingCapacity) • \(state.description)"
				} else {
					"Carrying \(carriedWeight) • \(state.description)"
				}
			} else {
				if let carryingCapacity {
					"Capacity \(carryingCapacity) • \(state.description)"
				} else {
					"\(state.description)"
				}
			}
		}
		else if let carriedWeight {
			if let carryingCapacity {
				"Carrying \(carriedWeight) of \(carryingCapacity)"
			} else {
				"Carrying \(carriedWeight)"
			}
		} else if let carryingCapacity {
			"Capacity \(carryingCapacity)"
		} else {
			""
		}
	}
}
