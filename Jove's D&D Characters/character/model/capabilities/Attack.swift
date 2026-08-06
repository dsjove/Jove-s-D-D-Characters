import Foundation

public struct Attack: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public static let attackDie = Die.d20

	public let name: String // H+P/G — rules content, player build, or GM customization
	public let source: Source // H+P/G — rules content, player build, or GM customization
	public let delivery: Delivery // H+P/G — rules content, player build, or GM customization
	public let resolution: Resolution // H+P/G — rules content, player build, or GM customization
	public let ability: Ability? // H+P/G — rules content, player build, or GM customization
	public let isProficient: Bool // H+P/G — rules content, player build, or GM customization
	public let attackBonus: Int? // C(H+P+A+S) — derived from ability/proficiency/items/effects; range: any Int when set
	public let range: Range
	public let target: Target
	public let damage: [Damage]
	public let criticalThreshold: Int // H+P/G — rules content, player build, or GM customization; range: 1...20
	public let properties: Set<Property> // H+P/G — rules content, player build, or GM customization
	public let effects: [Effect]
	public let notes: String // H+P/G — rules content, player build, or GM customization

	public init(
		_ name: String = .init(),
		source: Source = .other,
		delivery: Delivery = .melee,
		resolution: Resolution = .attackRoll,
		ability: Ability? = nil,
		isProficient: Bool = false,
		attackBonus: Int? = nil,
		range: Range = .reach5,
		target: Target = .oneCreature,
		damage: [Damage] = [],
		criticalThreshold: Int = attackDie.sides,
		properties: Set<Property> = [],
		effects: [Effect] = [],
		notes: String = ""
	) {
		self.name = name
		self.source = source
		self.delivery = delivery
		self.resolution = resolution
		self.ability = ability
		self.isProficient = isProficient
		self.attackBonus = attackBonus
		self.range = range
		self.target = target
		self.damage = damage
		self.criticalThreshold = min(max(criticalThreshold, 1), Self.attackDie.sides)
		self.properties = properties
		self.effects = effects
		self.notes = notes
	}

	public var isEmpty: Bool {
		name.isEmpty && damage.isEffectivelyEmpty && effects.isEffectivelyEmpty && notes.isEmpty
	}

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		try require((1...Self.attackDie.sides).contains(criticalThreshold), \Self.criticalThreshold, "must be in 1...\(Self.attackDie.sides)")
		try validate(range, at: \Self.range)
		try validate(target, at: \Self.target)
		try validate(damage, at: \Self.damage)
		try validate(effects, at: \Self.effects)
		switch resolution {
		case .attackRoll, .automatic:
			break
		case .savingThrow(_, let dc, _):
			try require(dc >= 1, \Self.resolution, "must be at least 1")
		}
	}
}

public extension Attack {
	enum Source: String, JCSEnum {
		case weapon
		case spell
		case naturalWeapon
		case unarmedStrike
		case classFeature
		case racialFeature
		case magicItem
		case other
	}

	enum Delivery: String, JCSEnum {
		case melee
		case ranged
	}

	enum Resolution: Codable, Sendable {
		case attackRoll
		case savingThrow(ability: Ability, dc: Int, result: SaveResult)
		case automatic
	}

	enum Ability: String, JCSEnum {
		case strength
		case dexterity
		case constitution
		case intelligence
		case wisdom
		case charisma
	}

	struct Range: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let kind: Kind // H+P/G — rules definition or custom content
		public let normal: Unit<LengthUnit> // H+P/G — rules definition or custom content
		public let long: Unit<LengthUnit>? // H+P/G — rules definition or custom content

		public init(
			_ kind: Kind = .reach,
			normal: Unit<LengthUnit> = .init(0, .foot),
			long: Unit<LengthUnit>? = nil
		) {
			let normal = Unit(max(normal.value, 0), normal.kind)
			self.kind = kind
			self.normal = normal
			self.long = long.map { candidate in
				let converted = candidate.kind.convert(candidate.value, to: normal.kind)
				return Unit(max(converted, normal.value), normal.kind)
			}
		}

		public static let reach5 = Self(.reach, normal: .init(5, .foot))

		public enum Kind: String, JCSEnum {
			case reach
			case distance
			case selfOrigin
			case sight
			case unlimited
		}


		public var isEmpty: Bool {
			normal.value == 0 && long.isEmpty
		}
	

		public func invariant() throws {
			try require(normal.value.isFinite && normal.value >= 0, \Self.normal.value, "must be finite and at least 0")
			if let long {
				try require(long.value.isFinite && long.value >= 0, \Self.long, "must be finite and at least 0")
				let converted = long.kind.convert(long.value, to: normal.kind)
				try require(converted >= normal.value, \Self.long, "must not be shorter than normal range")
			}
		}
	}

	struct Target: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let kind: Kind // H+P/G — rules definition or custom content
		public let count: Int? // H+P/G — rules definition or custom content; range: 1... when set
		public let area: Area?
		public let restrictions: String // H+P/G — rules definition or custom content

		public init(
			_ kind: Kind = .creature,
			count: Int? = nil,
			area: Area? = nil,
			restrictions: String = ""
		) {
			self.kind = kind
			self.count = count.map { max($0, 1) }
			self.area = area
			self.restrictions = restrictions
		}

		public static let oneCreature = Self(.creature, count: 1)
		public static let oneObject = Self(.object, count: 1)
		public static let oneTarget = Self(.creatureOrObject, count: 1)

		public enum Kind: String, JCSEnum {
			case creature
			case object
			case creatureOrObject
			case point
			case area
			case selfOnly
		}

		public var isEmpty: Bool {
			count == nil && area.isEmpty && restrictions.isEmpty
		}

		public func invariant() throws {
			if let count { try require(count >= 1, \Self.count, "must be at least 1 when set") }
			try validate(area, at: \Self.area)
			if kind == .area { try require(area != nil, \Self.area, "must be set when kind is area") }
		}
	}

	struct Area: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let shape: Shape // H+P/G — rules definition or custom content
		public let size: Unit<LengthUnit> // H+P/G — rules definition or custom content
		public let width: Unit<LengthUnit>? // H+P/G — rules definition or custom content

		public init(
			_ shape: Shape = .sphere,
			size: Unit<LengthUnit> = .init(0, .foot),
			width: Unit<LengthUnit>? = nil
		) {
			self.shape = shape
			self.size = .init(max(size.value, 0), size.kind)
			self.width = width.map { .init(max($0.value, 0), $0.kind) }
		}

		public enum Shape: String, JCSEnum {
			case cone
			case cube
			case cylinder
			case line
			case sphere
		}

		public var isEmpty: Bool {
			size.value == 0 && width.isEmpty
		}

		public func invariant() throws {
			try require(size.value.isFinite && size.value >= 0, \Self.size.value, "must be finite and at least 0")
			if let width { try require(width.value.isFinite && width.value >= 0, \Self.width, "must be finite and at least 0") }
			if shape == .line { try require(width != nil, \Self.width, "must be set for a line area") }
		}
	}

	struct Damage: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let roll: Roll
		public let type: DamageType // H+P/G — rules definition or custom content
		public let timing: Timing // H+P/G — rules definition or custom content
		public let appliesAbilityModifier: Bool // H+P/G — rules definition or custom content
		public let condition: String // H+P/G — rules definition or custom content

		public init(
			_ roll: Roll = .init(),
			type: DamageType = .bludgeoning,
			timing: Timing = .onHit,
			appliesAbilityModifier: Bool = false,
			condition: String = ""
		) {
			self.roll = roll
			self.type = type
			self.timing = timing
			self.appliesAbilityModifier = appliesAbilityModifier
			self.condition = condition
		}

		public var isEmpty: Bool {
			roll.isEmpty && condition.isEmpty
		}
	

		public func invariant() throws {
			try validate(roll, at: \Self.roll)
		}
	}

	enum DamageType: String, JCSEnum {
		case acid
		case bludgeoning
		case cold
		case fire
		case force
		case lightning
		case necrotic
		case piercing
		case poison
		case psychic
		case radiant
		case slashing
		case thunder
	}

	enum Timing: String, JCSEnum {
		case onHit
		case onMiss
		case startOfTurn
		case endOfTurn
		case immediate
	}

	enum SaveResult: String, JCSEnum {
		case noEffect
		case halfDamage
		case reducedEffect
		case endsEffect
	}

	enum Property: String, JCSEnum {
		case ammunition
		case finesse
		case heavy
		case light
		case loading
		case reach
		case thrown
		case twoHanded
		case versatile
		case special
		case silvered
		case magical
	}

	struct Effect: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let trigger: Trigger // H+P/G — rules definition or custom content
		public let condition: Condition? // H+P/G — rules definition or custom content
		public let duration: Duration? // H+P/G — rules definition or custom content
		public let savingThrow: SavingThrow?
		public let description: String // H+P/G — rules definition or custom content

		public init(
			trigger: Trigger = .onHit,
			condition: Condition? = nil,
			duration: Duration? = nil,
			savingThrow: SavingThrow? = nil,
			description: String = .init()
		) {
			self.trigger = trigger
			self.condition = condition
			self.duration = duration
			self.savingThrow = savingThrow
			self.description = description
		}

		public var isEmpty: Bool {
			condition == nil && duration == nil && savingThrow.isEmpty && description.isEmpty
		}

		public func invariant() throws {
			try validate(savingThrow, at: \Self.savingThrow)
			if let duration {
				switch duration {
				case .rounds(let value), .minutes(let value), .hours(let value):
					try require(value >= 1, \Self.duration, "numeric duration must be at least 1")
				case .special(let description):
					try requireMeaningful(description, \Self.duration)
				default:
					break
				}
			}
		}
	}

	enum Trigger: String, JCSEnum {
		case onHit
		case onMiss
		case onCriticalHit
		case onDamage
		case onFailedSave
		case onSuccessfulSave
	}

	enum Condition: String, JCSEnum {
		case blinded
		case charmed
		case deafened
		case frightened
		case grappled
		case incapacitated
		case invisible
		case paralyzed
		case petrified
		case poisoned
		case prone
		case restrained
		case stunned
		case unconscious
	}

	enum Duration: Codable, Sendable {
		case instantaneous
		case untilStartOfNextTurn
		case untilEndOfNextTurn
		case rounds(Int) // range: 1...
		case minutes(Int) // range: 1...
		case hours(Int) // range: 1...
		case untilSaveSucceeds
		case permanent
		case special(String)
	}

	struct SavingThrow: Codable, Sendable, EmptyCheckable, InvariantCheckable {
		public let ability: Ability // H+P/G — rules definition or custom content
		public let dc: Int? // H/C/G ? — nil means the DC has not been established; range: 1... when set
		public let timing: SaveTiming // H+P/G — rules definition or custom content
		public let success: SaveResult // H+P/G — rules definition or custom content

		public init(
			ability: Ability = .strength,
			dc: Int? = nil,
			timing: SaveTiming = .whenApplied,
			success: SaveResult = .noEffect
		) {
			self.ability = ability
			self.dc = dc.map { max($0, 1) }
			self.timing = timing
			self.success = success
		}

		public var isEmpty: Bool {
			dc == nil
		}
	

		public func invariant() throws {
			if let dc { try require(dc >= 1, \Self.dc, "must be at least 1 when set") }
		}
	}

	enum SaveTiming: String, JCSEnum {
		case whenApplied
		case startOfTurn
		case endOfTurn
	}
}
