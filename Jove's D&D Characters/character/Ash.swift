import Foundation

public let Ash = Character(
	person: .init(
		identity: .init(
			"Ash",
			ancestry: "Hobgoblin",
			classes: [
				.init("Rogue", specialty: "Thief", level: 5),
				.init("Fighter", specialty: "Battle Master", level: 5)],
			alignment: .init(.lawful, .neutral)
		),
		appearance: .init(
			age: .init(29, .year),
			height: .init(74, .inch),
			weight: .init(190, .pound),
			build: "Tall, lean, and wiry, with the compact strength of an experienced climber and street fighter.",
			skin: "Deep rust-red, weathered and marked by several small, faded scars.",
			eyes: "Dark amber, watchful and rarely at rest.",
			hair: "Black, coarse, and cut short for practicality, with slightly longer, uneven hair on top.",
			portrait: "ash_portrait"
		),
		background: .init(
			"Lorehold Student",
			organization: "Lorehold",
			role: "Field Specialist",
			clearance: "Expedition Recovery"
		),
		personality: .init(
			traits: ["Quiet, practical, observant, protective. Earns trust through actions."],
			ideals: ["Duty, competence, protection, and access to history for everyone."],
			bonds: ["Firestar; Lorehold; expedition teams; Rosie and her family."],
			flaws: ["Suspicious, slow to trust, carries burdens alone, struggles to ask for help."],
			manner: ["Matter-of-fact, sparing with thanks, watches exits, notices isolation, and protects first."]
		),
		relationships: [
			.init("Firestar", role: "Friend", detail: "Firestar made people feel welcome. Ash makes sure they survive after entering the room."),
		],
		backstory: .init("Ash became one of Lorehold's most dependable field researchers.")
	),
	life: .init(
		health: .init(
			maxHitPoints: 88
		),
		abilities: [
			.init(.strength, score: 10, modifier: 0, savingThrow: 0),
			.init(.dexterity, score: 18, modifier: 4, savingThrow: 8),
			.init(.constitution, score: 16, modifier: 3, savingThrow: 3),
			.init(.intelligence, score: 12, modifier: 1, savingThrow: 5),
			.init(.wisdom, score: 12, modifier: 1, savingThrow: 1),
			.init(.charisma, score: 8, modifier: -1, savingThrow: -1)
		],
		combat: [
			.init(.armorClass, score: 19),
			.init(.initiative, score: 4),
			.init(.inspiration, score: nil),
			.init(.proficiencyBonus, score: 4),
			.init(.passivePerception, score: 15)
		],
		movementAndSenses: .init(
			speeds: [.init(.walking, distance: .init(30, .foot))]
		)
	),
	capabilities: .init(
		attacks: [
			.init(
				"Rapier",
				source: .weapon,
				ability: .dexterity,
				isProficient: true,
				attackBonus: 8,
				damage: [.init(.init(1, .d8, 4), type: .piercing)],
				properties: [.finesse],
				notes: "Add Sneak Attack when its requirements are met."
			),
			.init(
				"Light Crossbow",
				source: .weapon,
				delivery: .ranged,
				ability: .dexterity,
				isProficient: true,
				attackBonus: 8,
				range: .init(.distance, normal: .init(80, .foot), long: .init(320, .foot)),
				damage: [.init(.init(1, .d8, 4), type: .piercing)],
				properties: [.ammunition, .loading, .twoHanded]
			),
			.init(
				"Dagger",
				source: .weapon,
				ability: .dexterity,
				isProficient: true,
				attackBonus: 8,
				range: .init(.distance, normal: .init(20, .foot), long: .init(60, .foot)),
				damage: [.init(.init(1, .d4, 4), type: .piercing)],
				properties: [.finesse, .light, .thrown]
			)
		],
		skills: [
			.init(.acrobatics, modifier: 8, mark: .proficient),
			.init(.animalHandling, modifier: 1, mark: .none),
			.init(.arcana, modifier: 5, mark: .proficient),
			.init(.athletics, modifier: 4, mark: .proficient),
			.init(.deception, modifier: -1, mark: .none),
			.init(.history, modifier: 5, mark: .proficient),
			.init(.insight, modifier: 1, mark: .none),
			.init(.intimidation, modifier: -1, mark: .none),
			.init(.investigation, modifier: 5, mark: .proficient),
			.init(.medicine, modifier: 1, mark: .none),
			.init(.nature, modifier: 1, mark: .none),
			.init(.perception, modifier: 5, mark: .proficient),
			.init(.performance, modifier: -1, mark: .none),
			.init(.persuasion, modifier: -1, mark: .none),
			.init(.religion, modifier: 1, mark: .none),
			.init(.sleightOfHand, modifier: 8, mark: .proficient),
			.init(.stealth, modifier: 12, mark: .expertise),
			.init(.survival, modifier: 1, mark: .none)
		],
		features: [
			.init("SNEAK ATTACK - 3d6", source: "Rogue", detail: "Once per turn when you have advantage, or when an enemy of the target is within 5 ft and you do not have disadvantage."),
			.init("CUNNING ACTION", source: "Rogue", detail: "Bonus action: Dash, Disengage, or Hide."),
			.init("FAST HANDS", source: "Thief", detail: "Bonus action: Sleight of Hand check, thieves' tools to disarm/open, or Use an Object."),
			.init("UNCANNY DODGE", source: "Rogue", detail: "Reaction when a visible attacker hits you: halve the attack's damage."),
			.init("EXTRA ATTACK", source: "Fighter", detail: "Attack twice whenever you take the Attack action."),
			.init("ACTION SURGE", source: "Fighter", counter: .init(recharge: .init(.shortRest)), detail: "Take one additional action on your turn."),
			.init("SECOND WIND", source: "Fighter", counter: .init(recharge: .init(.shortRest)), detail: "Bonus action once per short rest: regain 1d10 + 5 hit points."),
			.init("DEFENSE FIGHTING STYLE", source: "Fighter", detail: "While wearing armor, gain +1 AC. Already included in AC 19."),
			.init("SENTINEL", source: "Feat", detail: "Opportunity attacks ignore Disengage; a hit reduces speed to 0. Reaction attack when an adjacent enemy attacks someone else."),
			.init("Second-Story Work", source: "Rogue", detail: "climb speed equal to your normal speed. May use Dexterity instead of Strength to determine your jump distance")
		],
		spellcasting: [],
		maneuverSaveDC: 16,
		maneuvers: [
			.init("BAIT AND SWITCH", detail: "Swap with a willing creature within 5 ft; one of you gains +1d8 AC until your next turn."),
			.init("GOADING ATTACK", detail: "On hit, add 1d8 damage; failed Wisdom save gives disadvantage against others."),
			.init("RIPOSTE", detail: "Reaction after a melee miss: make one melee attack and add 1d8 damage.")
		],
		proficiencies: .init(
			languages: ["Common", "Goblin", "Draconic", "Dwarvish", "Thieves' Cant"],
			tools: ["Thieves' tools"],
			armor: ["Light armor", "Medium armor", "Shields"],
			weapons: ["Simple weapons", "Martial weapons"],
			expertise: ["Thieves' tools +12"]
		),
		resources: [
			.init(
				"Superiority Dice",
				counter: .init(
					recharge: .shortRest,
					maximum: 4,
					used: 0,
					suffix: "d8"
				)
			)
		]
	),
	possessions: .init(
		equipment: [
			.init("Rapier"),
			.init("Shield"),
			.init("Studded leather armor"),
			.init("Light crossbow", counter: .init(maximum: 20, suffix: "bolts")),
			.init("Daggers", counter: .init(maximum: 2)),
			.init("Thieves' tools"),
			.init("Explorer's pack"),
			.init("Lorehold field journal"),
			.init("Cloak of Displacement"),
			.init("Boots of Wandering")
		],
		moneys: .init(gold: 1000),
		valuables: .init([
			.init("CLOAK OF DISPLACEMENT", "Until Ash is hit, attack rolls against him have disadvantage. The effect returns at the start of his next turn."),
			.init("BOOTS OF WANDERING", "Prevent fatigue during long travel and exertion. Magical camouflage keeps them dusty, scuffed, and muddy.")
		])
	),
	notes: .init(
		dashboard: [
			.init("ON YOUR TURN", [.init("Action", "Attack twice / Dash / Disengage"),
								   .init("Bonus", "Cunning Action / Fast Hands"),
								   .init("Move", "30 ft; control nearby enemies")]),
			.init("REACTIONS", [.init("Dodge", "Halve one visible attacker's hit"),
								.init("Riposte", "Attack after a melee miss"),
								.init("Sentinel", "Opportunity hit makes speed 0")]),
			.init("RESOURCES", [.init("Dice", "4d8 superiority dice"),
								.init("Surge", "1 Action Surge"),
								.init("Wind", "1 Second Wind (1d10 + 5 HP)")])
		],
		reminders: [
			"Sneak Attack: once per turn, not once per round.", "Riposte can trigger Sneak Attack on another creature's turn.",
			"Uncanny Dodge happens after a hit is confirmed.", "Sentinel: opportunity hit reduces speed to 0.",
			"Cloak shuts off after the first hit; returns next turn."
		],
		campaign: []
	))
