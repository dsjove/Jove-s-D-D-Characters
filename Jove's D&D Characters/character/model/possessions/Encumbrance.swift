import Foundation

public enum EncumbranceState: String, JCSEnum {
	case unencumbered
	case encumbered
	case heavilyEncumbered
	case overloaded
}

public struct Encumbrance: Codable, Sendable, EmptyCheckable {
	public let carryingCapacity: Unit<WeightUnit>?
	public let carriedWeight: Unit<WeightUnit>?
	public let state: EncumbranceState?

	public init(carryingCapacity: Unit<WeightUnit>? = nil, carriedWeight: Unit<WeightUnit>? = nil, state: EncumbranceState? = nil) {
		self.carryingCapacity = carryingCapacity.map { .init(max($0.value, 0), $0.kind) }
		self.carriedWeight = carriedWeight.map { .init(max($0.value, 0), $0.kind) }
		self.state = state
	}

	public var isEmpty: Bool { carryingCapacity == nil && carriedWeight == nil && state == nil }
}
