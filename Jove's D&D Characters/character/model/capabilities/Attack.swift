import Foundation

public struct Attack: Codable, Sendable, EmptyCheckable {
	public static let attackDie = Die.d20

	public let name: String
	public let source: Source
	public let delivery: Delivery
	public let resolution: Resolution
	public let ability: Ability?
	public let isProficient: Bool
	public let attackBonus: Int?
	public let range: Range
	public let target: Target
	public let damage: [Damage]
	public let criticalThreshold: Int
	public let properties: Set<Property>
	public let effects: [Effect]
	public let notes: String

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

	struct Range: Codable, Sendable, EmptyCheckable {
		public let kind: Kind
		public let normal: Unit<LengthUnit>
		public let long: Unit<LengthUnit>?

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
	}

	struct Target: Codable, Sendable, EmptyCheckable {
		public let kind: Kind
		public let count: Int?
		public let area: Area?
		public let restrictions: String

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
	}

	struct Area: Codable, Sendable, EmptyCheckable {
		public let shape: Shape
		public let size: Unit<LengthUnit>
		public let width: Unit<LengthUnit>?

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
	}

	struct Damage: Codable, Sendable, EmptyCheckable {
		public let roll: Roll
		public let type: DamageType
		public let timing: Timing
		public let appliesAbilityModifier: Bool
		public let condition: String

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

	struct Effect: Codable, Sendable, EmptyCheckable {
		public let trigger: Trigger
		public let condition: Condition?
		public let duration: Duration?
		public let savingThrow: SavingThrow?
		public let description: String

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
		case rounds(Int)
		case minutes(Int)
		case hours(Int)
		case untilSaveSucceeds
		case permanent
		case special(String)
	}

	struct SavingThrow: Codable, Sendable, EmptyCheckable {
		public let ability: Ability
		public let dc: Int
		public let timing: SaveTiming
		public let success: SaveResult

		public init(
			ability: Ability = .strength,
			dc: Int = 0,
			timing: SaveTiming = .whenApplied,
			success: SaveResult = .noEffect
		) {
			self.ability = ability
			self.dc = max(dc, 0)
			self.timing = timing
			self.success = success
		}

		public var isEmpty: Bool {
			dc == 0
		}
	}

	enum SaveTiming: String, JCSEnum {
		case whenApplied
		case startOfTurn
		case endOfTurn
	}
}
