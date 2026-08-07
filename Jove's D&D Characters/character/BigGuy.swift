import Foundation

/// A deliberately comprehensive character used to exercise every part of the model and Basic Sheet UI.
public let BigGuy = Character(
	person: .init(
		identity: .init(
			"Big Guy",
			orientation: .init(bioSex: .man),
			ancestry: "Goliath",
			classes: [
				.init("Fighter", specialty: "Rune Knight", level: 12),
				.init("Wizard", specialty: "War Magic", level: 3),
			],
			alignment: .init(.lawful, .good)
		),
		appearance: .init(
			age: .init(38, .year),
			height: .init(8, .foot),
			weight: .init(420, .pound),
			build: "Massive and broad-shouldered",
			skin: "Slate gray with pale rune-like markings",
			eyes: "Ice blue",
			hair: "Black, braided, and streaked with silver",
			portrait: "big_guy_portrait"
		),
		background: .init(
			"Soldier",
			organization: "The Granite Watch",
			role: "Siege captain and arcane tactician",
			clearance: "Command staff"
		),
		personality: .init(
			traits: ["Speaks softly so others must listen.", "Measures every doorway before entering."],
			ideals: ["Strength exists to protect people who have less of it."],
			bonds: ["Owes his life to the Granite Watch.", "Carries his mentor's broken shield."],
			flaws: ["Assumes every problem can eventually be lifted, broken, or outlasted."],
			manner: ["Folds his arms while thinking.", "Calls everyone smaller than him 'little friend'."]
		),
		relationships: [
			.init("Captain Mira Vale", role: "Commander", detail: "Trusted commander and former adventuring companion."),
			.init("Pebble", role: "Familiar", detail: "A stone-colored owl who scouts narrow places BigGuy cannot enter."),
		],
		associatedCreatures: [
			.init(
				"Pebble",
				kind: .familiar,
				statBlock: .init(
					armorClass: 13,
					health: .init(maxHitPoints: 7, hitPoints: 5, hitDice: [.init(1, .d4)], remainingHitDice: [.init(1, .d4)], temporaryHitPoints: 2, deathSaveSuccesses: 0, deathSaveFailures: 0, isStable: false),
					abilities: [
						.init(.strength, score: 3, modifier: -4, savingThrow: -4),
						.init(.dexterity, score: 15, modifier: 2, savingThrow: 2),
						.init(.constitution, score: 8, modifier: -1, savingThrow: -1),
						.init(.intelligence, score: 2, modifier: -4, savingThrow: -4),
						.init(.wisdom, score: 12, modifier: 1, savingThrow: 1),
						.init(.charisma, score: 7, modifier: -2, savingThrow: -2),
					],
					speeds: [.init(.walking, feet: 5), .init(.flying, feet: 60)],
					attacks: [.init("Talons", source: .naturalWeapon, delivery: .melee, ability: .dexterity, isProficient: true, attackBonus: 4, damage: [.init(.init(1, .d1), type: .slashing)], notes: "Cannot attack while acting as a familiar unless permitted by a feature.")],
					features: [.init("Flyby", source: "Owl", detail: "Does not provoke opportunity attacks when flying out of reach.")],
					notes: ["Communicates telepathically within 100 feet."]
				),
				notes: ["Usually perched on BigGuy's shoulder."]
			),
			.init("Granite", kind: .mount, statBlock: .init(armorClass: 15, health: .init(maxHitPoints: 45, hitPoints: 45), speeds: [.init(.walking, feet: 50)], features: [.init("Sure-Footed", source: "Warhorse", detail: "Advantage on saves against being knocked prone.")], notes: ["A heavily armored draft horse."]), notes: ["Carries stored equipment."]),
		],
		backstory: .init("Backstory", [
			.init("Origin", "Raised among mountain masons and trained to defend high passes."),
			.init("Turning Point", "Discovered giant runes in a collapsed fortress and later studied battlefield magic."),
			.init("Goal", "Rebuild the fortress as a refuge and school."),
		])
	),
	life: .init(
		health: .init(
			maxHitPoints: 168,
			hitPoints: 143,
			hitDice: [.init(12, .d10), .init(3, .d6)],
			remainingHitDice: [.init(8, .d10), .init(2, .d6)],
			temporaryHitPoints: 11,
			deathSaveSuccesses: 1,
			deathSaveFailures: 1,
			isStable: true
		),
		abilities: [
			.init(.strength, score: 22, modifier: 6, savingThrow: 11),
			.init(.dexterity, score: 12, modifier: 1, savingThrow: 1),
			.init(.constitution, score: 20, modifier: 5, savingThrow: 10),
			.init(.intelligence, score: 16, modifier: 3, savingThrow: 8),
			.init(.wisdom, score: 14, modifier: 2, savingThrow: 2),
			.init(.charisma, score: 10, modifier: 0, savingThrow: 0),
		],
		combat: [
			.init(.armorClass, score: 22),
			.init(.initiative, score: 1),
			.init(.proficiencyBonus, score: 5),
			.init(.passivePerception, score: 17),
			.init(.inspiration, score: 1)
		],
		defenses: .init(
			damageResistances: [.bludgeoning, .cold, .fire],
			vulnerabilities: [.psychic],
			damageImmunities: [.poison],
			conditionImmunities: [.frightened, .poisoned],
			notes: ["Resistance to weapon damage applies while Stone's Endurance is active."]
		),
		movementAndSenses: .init(
			speeds: [
				.init(.walking, distance: .init(30, .foot)),
				.init(.climbing, distance: .init(30, .foot)),
				.init(.swimming, distance: .init(20, .foot)),
				.init(.flying, distance: .init(60, .foot)),
				.init(.burrowing, distance: .init(10, .foot)),
			],
			senses: [
				.init(.darkvision, range: .init(60, .foot), detail: "Sees dim light as bright light."),
				.init(.blindsight, range: .init(10, .foot), detail: "Rune-assisted spatial awareness."),
				.init(.tremorsense, range: .init(30, .foot), detail: "Only while touching stone."),
				.init(.truesight, range: .init(5, .foot), detail: "Granted by the Eye Rune."),
				.init(.other, range: .init(1, .mile), detail: "Can hear the Granite Watch signal horn."),
			],
			notes: ["Flying speed comes from Winged Boots and is unavailable when they are inactive."]
		),
		currentConditions: .init(
			conditions: [.grappled, .poisoned],
			exhaustion: 2,
			persistentEffects: ["Enlarged by Giant's Might", "Armor of Agathys has 11 temporary hit points remaining"],
			concentration: "Fly"
		)
	),
	capabilities: .init(
		attacks: [
			.init(
				"Runic Greatsword",
				source: .magicItem,
				delivery: .melee,
				resolution: .attackRoll,
				ability: .strength,
				isProficient: true,
				attackBonus: 12,
				range: .init(.reach, normal: .init(10, .foot)),
				target: .init(.creatureOrObject, count: 1, restrictions: "A target within reach"),
				damage: [
					.init(.init(2, .d6, 7), type: .slashing, appliesAbilityModifier: true),
					.init(.init(1, .d8), type: .force, timing: .onHit, condition: "While Giant's Might is active"),
				],
				criticalThreshold: 19,
				properties: [.heavy, .reach, .twoHanded, .magical, .silvered, .special],
				effects: [
					.init(
						trigger: .onCriticalHit,
						condition: .prone,
						duration: .untilEndOfNextTurn,
						savingThrow: .init(ability: .strength, dc: 19, timing: .whenApplied, success: .noEffect),
						description: "The target is knocked prone on a failed save."
					),
				],
				notes: "The blade's runes glow when a giant is within one mile."
			),
			.init(
				"Boulder Toss",
				source: .racialFeature,
				delivery: .ranged,
				resolution: .savingThrow(ability: .dexterity, dc: 19, result: .halfDamage),
				ability: .strength,
				isProficient: true,
				attackBonus: 11,
				range: .init(.distance, normal: .init(60, .foot), long: .init(180, .foot)),
				target: .init(.area, area: .init(.sphere, size: .init(10, .foot)), restrictions: "Centered on a visible point"),
				damage: [.init(.init(4, .d10, 6), type: .bludgeoning, timing: .immediate)],
				properties: [.thrown],
				effects: [
					.init(trigger: .onFailedSave, condition: .restrained, duration: .untilSaveSucceeds, description: "Pinned beneath rubble."),
				],
				notes: "Requires a loose object weighing at least 50 pounds."
			),
			.init(
				"Thunder Line",
				source: .spell,
				delivery: .ranged,
				resolution: .automatic,
				ability: .intelligence,
				isProficient: true,
				attackBonus: 8,
				range: .init(.selfOrigin, normal: .init(100, .foot)),
				target: .init(.area, area: .init(.line, size: .init(100, .foot), width: .init(5, .foot))),
				damage: [.init(.init(6, .d8), type: .thunder, timing: .immediate)],
				properties: [.magical],
				effects: [.init(trigger: .onDamage, condition: .deafened, duration: .minutes(1), description: "A concussive rune erupts in a line.")],
				notes: "Demonstrates an automatic-resolution area attack."
			),
		],
		skills: [
			.init(.acrobatics, modifier: 1, mark: .none),
			.init(.animalHandling, modifier: 2, mark: .none),
			.init(.arcana, modifier: 8, mark: .proficient),
			.init(.athletics, modifier: 16, mark: .expertise),
			.init(.deception, modifier: 0, mark: .none),
			.init(.history, modifier: 8, mark: .proficient),
			.init(.insight, modifier: 7, mark: .proficient),
			.init(.intimidation, modifier: 5, mark: .proficient),
			.init(.investigation, modifier: 8, mark: .proficient),
			.init(.medicine, modifier: 2, mark: .none),
			.init(.nature, modifier: 3, mark: .none),
			.init(.perception, modifier: 7, mark: .proficient),
			.init(.performance, modifier: 0, mark: .none),
			.init(.persuasion, modifier: 5, mark: .proficient),
			.init(.religion, modifier: 3, mark: .none),
			.init(.sleightOfHand, modifier: 1, mark: .none),
			.init(.stealth, modifier: 1, mark: .none),
			.init(.survival, modifier: 7, mark: .proficient),
		],
		features: [
			.init("Giant's Might", source: "Rune Knight", counter: .init(recharge: .longRest, maximum: 5, used: 1), detail: "Become Large, gain advantage on Strength checks and saves, and deal extra damage."),
			.init("Action Surge", source: "Fighter", counter: .init(recharge: .shortRest, maximum: 2, used: 1), detail: "Take one additional action."),
			.init("Arcane Deflection", source: "War Magic", counter: .init(recharge: .turnOrRound, maximum: 1, used: 0, suffix: "reaction"), detail: "Use a reaction for +2 AC or +4 to a saving throw."),
		],
		spellcasting: [
			.init(
				"Wizard",
				tradition: .arcane,
				ability: .intelligence,
				spellSaveDC: 16,
				spellAttackBonus: 8,
				slots: [
					.init(.first, maximum: 4, used: 1),
					.init(.second, maximum: 2, used: 1),
				],
				spells: [
					.init("Booming Blade", level: .cantrip, school: "Evocation", preparation: .known, castingTime: "1 action", range: "Self (5-foot radius)", components: ["S", "M"], duration: "1 round", ritual: false, concentration: false, isPrepared: nil, detail: "Weapon attack wrapped in booming energy."),
					.init("Shield", level: .first, school: "Abjuration", preparation: .prepared, castingTime: "1 reaction", range: "Self", components: ["V", "S"], duration: "1 round", ritual: false, concentration: false, isPrepared: true, detail: "+5 AC until the start of the next turn."),
					.init("Detect Magic", level: .first, school: "Divination", preparation: .alwaysPrepared, castingTime: "1 action", range: "Self", components: ["V", "S"], duration: "Up to 10 minutes", ritual: true, concentration: true, isPrepared: true, detail: "Sense magic within 30 feet."),
					.init("Misty Step", level: .second, school: "Conjuration", preparation: .prepared, castingTime: "1 bonus action", range: "Self", components: ["V"], duration: "Instantaneous", ritual: false, concentration: false, isPrepared: false, detail: "Teleport up to 30 feet."),
				],
				focus: "A fist-sized granite rune stone",
				notes: ["Spellbook is etched onto linked metal plates."]
			),
			.init(
				"Goliath Runes",
				tradition: .innate,
				ability: .constitution,
				spellSaveDC: 18,
				spellAttackBonus: 10,
				spells: [.init("Stone Shape", level: .fourth, school: "Transmutation", preparation: .innate, castingTime: "1 action", range: "Touch", components: ["S"], duration: "Instantaneous", isPrepared: true, detail: "Shape a stone object or section of stone.")],
				focus: "Body runes",
				notes: ["Does not require material components."]
			),
		],
		maneuvers: [
			.init("Brace", detail: "Use a reaction to attack a creature entering reach."),
			.init("Commander's Strike", detail: "Direct an ally to make a weapon attack."),
		],
		proficiencies: .init(
			savingThrows: [.strength, .constitution, .intelligence],
			languages: ["Common", "Giant", "Dwarvish", "Draconic"],
			tools: ["Mason's tools", "Smith's tools", "Vehicles (land)"],
			armor: ["Light armor", "Medium armor", "Heavy armor", "Shields"],
			weapons: ["Simple weapons", "Martial weapons"],
			expertise: ["Athletics", "Siege engineering"],
			other: [
				.init("Special Training", [.init("Siege Weapons", "Proficient with ballistae, mangonels, and rams."), .init("Runes", "Can read and inscribe Giant runes.")]),
			]
		),
		resources: [
			.init("Superiority Dice", counter: .init(recharge: .shortRest, maximum: 5, used: 2, suffix: "d10"), notes: ["Used by maneuvers."]),
			.init("Rune Invocations", counter: .init(recharge: .longRest, maximum: 4, used: 1, suffix: "runes"), notes: ["Each known rune can be invoked once."]),
			.init("Legendary Effort", counter: .init(recharge: .oncePerDay, maximum: nil, used: 3, suffix: "points spent"), notes: ["An intentionally unbounded counter for UI testing."]),
		]
	),
	possessions: .init(
		equipment: [
			.init("Runic plate armor", location: .equipped, quantity: 1, unitWeight: .init(65, .pound), armorContribution: 18, attunement: .attuned, charges: .init(recharge: .dawn, maximum: 5, used: 2), isConsumable: false, notes: ["Automatically resizes with Giant's Might."]),
			.init("Tower shield", location: .equipped, quantity: 1, unitWeight: .init(18, .pound), armorContribution: 2, attunement: .notRequired, isConsumable: false, notes: ["Painted with the Granite Watch crest."]),
			.init("Potion of supreme healing", location: .carried, quantity: 3, unitWeight: .init(8, .ounce), attunement: .notRequired, isConsumable: true, notes: ["Restores 10d4 + 20 hit points."]),
			.init("Portable ram", location: .stored, quantity: 1, unitWeight: .init(35, .pound), attunement: .unattuned, isConsumable: false, notes: ["Stored on the wagon."]),
		],
		moneys: .init(copper: 12, silver: 34, electrum: 5, gold: 678, platinum: 9),
		valuables: .init([
			.init("Star sapphire", "A deep-blue gemstone with a six-pointed star.", itemCount: 2, .platinum, 50),
			.init("Mentor's shield fragment", "Sentimental value; not for sale.", itemCount: 1),
		]),
		encumbrance: .init(carryingCapacity: .init(660, .pound), carriedWeight: .init(287.5, .pound), state: .encumbered)
	),
	advancement: .init(
		method: .experience,
		currentxperience: 165_000,
		nextLevelExperience: 195_000,
		milestoneProgress: "Two of three giant seals restored",
		feats: ["Great Weapon Master", "Sentinel", "War Caster"],
		abilityScoreImprovements: ["Strength +2", "Constitution +2", "Intelligence +2"],
		notes: ["Next level planned for Fighter.", "Consider Resilient (Wisdom) at the next feat opportunity."]
	),
	notes: .init(
		dashboard: [
			.init("TURN OPTIONS", [.init("Action", "Attack three times, cast a spell, or use a maneuver."), .init("Bonus Action", "Giant's Might, Second Wind, or Misty Step."), .init("Reaction", "Shield, Arcane Deflection, Brace, or an opportunity attack.")]),
			.init("ACTIVE EFFECTS", [.init("Concentration", "Fly"), .init("Size", "Large from Giant's Might"), .init("Temporary HP", "11 from Armor of Agathys")]),
		],
		reminders: ["Apply the extra Giant's Might damage only once per turn.", "Arcane Deflection limits spellcasting on the next turn."],
		campaign: ["The northern giant seal is beneath the ruined observatory.", "Captain Vale expects a report before the next full moon."]
	)
)
