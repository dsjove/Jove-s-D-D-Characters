import Foundation

public struct Appearance: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let age: Unit<TimeUnit>? // P+T/G ? — initial value plus time/campaign effects
	public let height: Unit<LengthUnit>? // P/G ? — player-authored or campaign-altered description
	public let weight: Unit<WeightUnit>? // P/G ? — player-authored or campaign-altered description
	public let build: String // P/G ~ — player-authored or campaign-altered description
	public let skin: String // P/G ~ — player-authored or campaign-altered description
	public let eyes: String // P/G ~ — player-authored or campaign-altered description
	public let hair: String // P/G ~ — player-authored or campaign-altered description
	public let portrait: String // P/G ~ — player-authored or campaign-altered description

	public init(
		age: Unit<TimeUnit>? = nil,
		height: Unit<LengthUnit>? = nil,
		weight: Unit<WeightUnit>? = nil,
		build: String = .init(),
		skin: String = .init(),
		eyes: String = .init(),
		hair: String = .init(),
		portrait: String = .init()
	) {
		self.age = age
		self.height = height
		self.weight = weight
		self.build = build
		self.skin = skin
		self.eyes = eyes
		self.hair = hair
		self.portrait = portrait
	}

	public var isEmpty: Bool {
		age == nil && height == nil && weight == nil && build.isEmpty && skin.isEmpty && eyes.isEmpty && hair.isEmpty && portrait.isEmpty
	}

	public func invariant() throws {
		if let age { try require(age.value.isFinite && age.value >= 0, \Self.age, "must be finite and at least 0") }
		if let height { try require(height.value.isFinite && height.value >= 0, \Self.height, "must be finite and at least 0") }
		if let weight { try require(weight.value.isFinite && weight.value >= 0, \Self.weight, "must be finite and at least 0") }
	}
}
