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

public struct SpellSlotCounter: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let level: SpellLevel // H+A ! — slot tier unlocked through advancement
	public let counter: ResourceCounter

	public init(
		_ level: SpellLevel = .first,
		maximum: Int = 0,
		used: Int = 0,
		recharge: Recharge = .longRest
	) {
		self.level = level
		self.counter = .init(recharge: recharge, maximum: maximum, used: used)
	}

	public var maximum: Int { counter.maximum ?? 0 }
	public var used: Int { counter.used }
	public var remaining: Int { counter.remaining ?? 0 }

	public var isEmpty: Bool {
		counter.isEmpty || maximum == 0
	}

	public func invariant() throws {
		try validate(counter, at: \Self.counter)
		try require(counter.maximum != nil, \Self.counter.maximum, "must be established for a spell slot counter")
	}
}

public struct Spell: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P/G ! — rules spell data or custom content
	public let level: SpellLevel // H+P/G ! — rules spell data or custom content
	public let school: String // H+P/G ~ — rules spell data or custom content
	public let preparation: SpellPreparation // H+P/G ! — rules spell data or custom content
	public let castingTime: String // H+P/G ~ — rules spell data or custom content
	public let range: String // H+P/G ~ — rules spell data or custom content
	public let components: [String] // H+P/G ~ — rules spell data or custom content
	public let duration: String // H+P/G ~ — rules spell data or custom content
	public let ritual: Bool // H+P/G ! — rules spell data or custom content
	public let concentration: Bool // H+P/G ! — rules spell data or custom content
	public let isPrepared: Bool? // P+S ? — player preparation state, often changed after rest
	public let detail: String // H+P/G ~ — rules spell data or custom content

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
		name.isEmpty && level == .cantrip && school.isEmpty && preparation == .known && castingTime.isEmpty && range.isEmpty && components.isEmpty && duration.isEmpty && !ritual && !concentration && isPrepared == nil && detail.isEmpty
	}

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
	}
}

public struct Spellcasting: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let source: String // H+P/A ~ — rules source selected through build/advancement
	public let tradition: MagicTradition? // H+P/A ? — rules source selected through build/advancement
	public let ability: Ability? // H+P/A ? — rules source selected through build/advancement
	public let spellSaveDC: Int? // C(H+P+A+S) ? — derived from ability, proficiency, and effects; range: 1... when set
	public let spellAttackBonus: Int? // C(H+P+A+S) ? — derived from ability, proficiency, and effects; range: any Int when set
	public let slots: [SpellSlotCounter]
	public let spells: [Spell]
	public let focus: String? // P/H/G ? — nil means no focus has been established
	public let notes: [String] // P/H/G ~ — player, rules, or campaign detail

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

	public func invariant() throws {
		if let spellSaveDC { try require(spellSaveDC >= 1, \Self.spellSaveDC, "must be at least 1 when set") }
		try validate(slots, at: \Self.slots)
		try validate(spells, at: \Self.spells)
		try requireUnique(slots.map(\.level), \Self.slots, "must not contain duplicate spell levels")
	}
}
