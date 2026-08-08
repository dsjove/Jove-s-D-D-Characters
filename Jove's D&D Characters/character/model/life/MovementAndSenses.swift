import Foundation

public enum MovementMode: String, JCSEnum {
	case walking
	case climbing
	case swimming
	case flying
	case burrowing
}

public struct MovementSpeed: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let mode: MovementMode // H ! — rules-defined movement mode
	public let distance: Unit<LengthUnit> // H+C/S ! — rules base plus active effects

	public init(_ mode: MovementMode = .walking, distance: Unit<LengthUnit> = .init(0, .foot)) {
		self.mode = mode
		self.distance = .init(max(distance.value, 0), distance.kind)
	}

	public init(_ mode: MovementMode = .walking, feet: Double) {
		self.init(mode, distance: .init(feet, .foot))
	}

	public var isEmpty: Bool { distance.value == 0 }

	public func invariant() throws {
		try require(distance.value.isFinite && distance.value >= 0, \Self.distance.value, "must be finite and at least 0")
	}
}

public enum SenseKind: String, JCSEnum {
	case darkvision
	case blindsight
	case tremorsense
	case truesight
	case other
}

public struct SpecialSense: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let kind: SenseKind // H+P/G ! — rules feature or campaign-granted sense
	public let range: Unit<LengthUnit>? // H+P/G ? — rules feature or campaign-granted sense
	public let detail: String // H+P/G ~ — rules feature or campaign-granted sense

	public init(_ kind: SenseKind = .other, range: Unit<LengthUnit>? = nil, detail: String = "") {
		self.kind = kind
		self.range = range.map { .init(max($0.value, 0), $0.kind) }
		self.detail = detail
	}

	public var isEmpty: Bool { range == nil && detail.isEmpty }

	public func invariant() throws {
		if let range { try require(range.value.isFinite && range.value >= 0, \Self.range, "must be finite and at least 0") }
	}
}

public struct MovementAndSenses: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let speeds: [MovementSpeed]
	public let senses: [SpecialSense]
	public let notes: [String] // H/P/G ~ — rules, player choice, or campaign source

	public init(speeds: [MovementSpeed] = [], senses: [SpecialSense] = [], notes: [String] = []) {
		self.speeds = speeds
		self.senses = senses
		self.notes = notes
	}

	public var isEmpty: Bool {
		speeds.isEffectivelyEmpty && senses.isEffectivelyEmpty && notes.isEmpty
	}

	public func invariant() throws {
		try validate(speeds, at: \Self.speeds)
		try validate(senses, at: \Self.senses)
		try requireUnique(speeds.map(\.mode), \Self.speeds, "must not contain duplicate movement modes")
	}
}
