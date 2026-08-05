import Foundation

public enum MovementMode: String, JCSEnum {
	case walking
	case climbing
	case swimming
	case flying
	case burrowing
}

public struct MovementSpeed: Codable, Sendable, EmptyCheckable {
	public let mode: MovementMode
	public let distance: Unit<LengthUnit>

	public init(_ mode: MovementMode = .walking, distance: Unit<LengthUnit> = .init(0, .foot)) {
		self.mode = mode
		self.distance = .init(max(distance.value, 0), distance.kind)
	}

	public init(_ mode: MovementMode = .walking, feet: Double) {
		self.init(mode, distance: .init(feet, .foot))
	}

	public var isEmpty: Bool { distance.value == 0 }
}

public enum SenseKind: String, JCSEnum {
	case darkvision
	case blindsight
	case tremorsense
	case truesight
	case other
}

public struct SpecialSense: Codable, Sendable, EmptyCheckable {
	public let kind: SenseKind
	public let range: Unit<LengthUnit>?
	public let detail: String

	public init(_ kind: SenseKind = .other, range: Unit<LengthUnit>? = nil, detail: String = "") {
		self.kind = kind
		self.range = range.map { .init(max($0.value, 0), $0.kind) }
		self.detail = detail
	}

	public var isEmpty: Bool { range == nil && detail.isEmpty }
}

public struct MovementAndSenses: Codable, Sendable, EmptyCheckable {
	public let speeds: [MovementSpeed]
	public let senses: [SpecialSense]
	public let notes: [String]

	public init(speeds: [MovementSpeed] = [], senses: [SpecialSense] = [], notes: [String] = []) {
		self.speeds = speeds
		self.senses = senses
		self.notes = notes
	}

	public var isEmpty: Bool {
		speeds.isEffectivelyEmpty && senses.isEffectivelyEmpty && notes.isEmpty
	}
}
