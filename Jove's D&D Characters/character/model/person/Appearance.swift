import Foundation

public struct Appearance: Codable, Sendable, EmptyCheckable {
	public let age: Unit<TimeUnit>?
	public let height: Unit<LengthUnit>?
	public let weight: Unit<WeightUnit>?
	public let build: String
	public let skin: String
	public let eyes: String
	public let hair: String
	public let portrait: String

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
}
