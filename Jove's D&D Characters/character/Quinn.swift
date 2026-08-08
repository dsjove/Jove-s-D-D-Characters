import Foundation

public let Quinn = Character(
	person: .init(
		identity: .init(
			"Quinn Amethyst Starsong",
			orientation: .init(bioSex: .woman),
			ancestry: "Half-Elf",
			creatureType: .humanoid,
			size: .medium,
			classes: [
				.init("Sorcerer", specialty: "Wild Magic", level: 10)
			],
			alignment: .init(.chaotic, .neutral)
		),
		appearance: .init(
			age: .init(27, .year),
			height: .init(72, .inch),
			weight: .init(165, .pound),
			build: "Willowy",
			skin: "Pale, almost ghostly",
			eyes: "Violet and intense, a little crazy",
			hair: "Bright white, with strands and chunks dyed in rainbow hues",
			portrait: "quinn_portait"
		),
		background: .init(
			"Entertainer",
			organization: "Prismari"
			//role
			//clearance
		),
	),
	life: .init(
		health: .init(
			maxHitPoints: 75
		),
		abilities: [
			.init(.strength, score: 12, modifier: 1, savingThrow: 2),
			.init(.dexterity, score: 14, modifier: 2, savingThrow: 3),
			.init(.constitution, score: 16, modifier: 3, savingThrow: 8),
			.init(.intelligence, score: 13, modifier: 1, savingThrow: 2),
			.init(.wisdom, score: 13, modifier: 1, savingThrow: 2),
			.init(.charisma, score: 20, modifier: 5, savingThrow: 10)
		],
		combat: [
			.init(.armorClass, score: 14),
			.init(.initiative, score: 2),
			.init(.inspiration, score: nil),
			.init(.proficiencyBonus, score: 4),
			.init(.passivePerception, score: 11)
		],
		movementAndSenses: .init(
			speeds: [.init(.walking, distance: .init(30, .foot))]
		)
	),
	capabilities: .init(
		attacks: [
			.init(
				"Quarterstaff",
				source: .weapon,
				ability: .strength,
				isProficient: true,
				attackBonus: 5,
				damage: [.init(.init(1, .d6, 1), type: .bludgeoning)],
				properties: [.versatile],
				notes: "Two-handed damage: 1d8 + 1 bludgeoning."
			),
			.init(
				"Dagger",
				source: .weapon,
				ability: .dexterity,
				isProficient: true,
				attackBonus: 6,
				range: .init(.distance, normal: .init(20, .foot), long: .init(60, .foot)),
				damage: [.init(.init(1, .d4, 2), type: .piercing)],
				properties: [.finesse, .light, .thrown]
			)
		],
		skills: [
			.init(.acrobatics, modifier: 6, mark: .proficient),
			.init(.animalHandling, modifier: 1, mark: .none),
			.init(.arcana, modifier: 1, mark: .none),
			.init(.athletics, modifier: 1, mark: .none),
			.init(.deception, modifier: 9, mark: .proficient),
			.init(.history, modifier: 1, mark: .none),
			.init(.insight, modifier: 1, mark: .none),
			.init(.intimidation, modifier: 5, mark: .none),
			.init(.investigation, modifier: 1, mark: .none),
			.init(.medicine, modifier: 1, mark: .none),
			.init(.nature, modifier: 1, mark: .none),
			.init(.perception, modifier: 1, mark: .none),
			.init(.performance, modifier: 9, mark: .proficient),
			.init(.persuasion, modifier: 9, mark: .proficient),
			.init(.religion, modifier: 1, mark: .none),
			.init(.sleightOfHand, modifier: 6, mark: .proficient),
			.init(.stealth, modifier: 6, mark: .proficient),
			.init(.survival, modifier: 1, mark: .none)
		],
		features: [
			.init("Darkvision", source: "Half-Elf", detail: "60 feet"),
			.init("Fey Ancestry", source: "Half-Elf", detail: "Advantage on saving throws against being charmed, and magic can't put you to sleep."),
			.init("By Popular Demand", source: "Entertainer", detail: "You can always find a place to perform and receive modest lodging."),
			.init("Wild Magic Surge", source: "Wild Magic", detail: "d20"),
			.init("Tides of Chaos", source: "Wild Magic", counter: .init(recharge: .longRest, maximum: 1, used:0, suffix: "Or after wild magic surge roll"), detail: "Advantage to one attack, save, or ability roll"),
			.init("Bend Luck", source: "Wild Magic", detail: "A creature you can see makes attack roll, ability check, or save; use reaction and 2 sp to roll 1d4 to add a bonus/penalty to roll."),
			.init("Font of Magic", source: "Sorcerer", counter: .init(recharge: .longRest, maximum: 10, used: 0), detail:"Sorcery Points")
		],
		// TODO: Add spellcasting sources, slots, and spells when confirmed.
		spellcasting: [],
	)
)
