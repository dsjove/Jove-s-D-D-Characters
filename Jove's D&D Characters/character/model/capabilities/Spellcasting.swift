import Foundation

public enum MagicTradition: String, JCSEnum {
	case arcane
	case divine
	case primal
	case psionic
	case innate
	case other
}

public enum SpellPreparation: String, JCSEnum {
	case known
	case prepared
	case alwaysPrepared
	case innate
}

public enum SpellLevel: Int, JCSEnum {
	case cantrip = 0
	case first = 1
	case second = 2
	case third = 3
	case fourth = 4
	case fifth = 5
	case sixth = 6
	case seventh = 7
	case eighth = 8
	case ninth = 9
}

extension SpellLevel {
	public var description: String {
		self == .cantrip ? "Cantrip" : "Level \(rawValue)"
	}

	public var abbreviation: String {
		self == .cantrip ? "C" : rawValue.description
	}
}

public struct SpellSlotCounter: Codable, Sendable, EmptyCheckable {
	public let level: SpellLevel
	public let counter: ResourceCounter

	public init(
		_ level: SpellLevel = .first,
		maximum: Int = 0,
		used: Int = 0
	) {
		self.level = level
		self.counter = .init(recharge: .longRest, maximum: maximum, used: used)
	}

	public var maximum: Int { counter.maximum ?? 0 }
	public var used: Int { counter.used }
	public var remaining: Int { counter.remaining ?? 0 }

	public var isEmpty: Bool {
		counter.isEmpty || maximum == 0
	}
}

public struct Spell: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let level: SpellLevel
	public let school: String
	public let preparation: SpellPreparation
	public let castingTime: String
	public let range: String
	public let components: [String]
	public let duration: String
	public let ritual: Bool
	public let concentration: Bool
	public let isPrepared: Bool?
	public let detail: String

	public init(
		_ name: String = .init(),
		level: SpellLevel = .cantrip,
		school: String = .init(),
		preparation: SpellPreparation = .known,
		castingTime: String = .init(),
		range: String = .init(),
		components: [String] = [],
		duration: String = .init(),
		ritual: Bool = false,
		concentration: Bool = false,
		isPrepared: Bool? = nil,
		detail: String = .init()
	) {
		self.name = name
		self.level = level
		self.school = school
		self.preparation = preparation
		self.castingTime = castingTime
		self.range = range
		self.components = components
		self.duration = duration
		self.ritual = ritual
		self.concentration = concentration
		self.isPrepared = isPrepared
		self.detail = detail
	}

	public var isEmpty: Bool {
		name.isEmpty && school.isEmpty && castingTime.isEmpty && range.isEmpty && components.isEmpty && duration.isEmpty && detail.isEmpty
	}
}

public struct Spellcasting: Codable, Sendable, EmptyCheckable {
	public let source: String
	public let tradition: MagicTradition?
	public let ability: Ability?
	public let spellSaveDC: Int?
	public let spellAttackBonus: Int?
	public let slots: [SpellSlotCounter]
	public let spells: [Spell]
	public let focus: String?
	public let notes: [String]

	public init(
		_ source: String = .init(),
		tradition: MagicTradition? = nil,
		ability: Ability? = nil,
		spellSaveDC: Int? = nil,
		spellAttackBonus: Int? = nil,
		slots: [SpellSlotCounter] = [],
		spells: [Spell] = [],
		focus: String? = nil,
		notes: [String] = []
	) {
		self.source = source
		self.tradition = tradition
		self.ability = ability
		self.spellSaveDC = spellSaveDC
		self.spellAttackBonus = spellAttackBonus
		self.slots = slots
		self.spells = spells
		self.focus = focus
		self.notes = notes
	}

	public var isEmpty: Bool {
		source.isEmpty && tradition == nil && ability == nil && spellSaveDC == nil && spellAttackBonus == nil && slots.isEffectivelyEmpty && spells.isEffectivelyEmpty && focus == nil && notes.isEmpty
	}
}
