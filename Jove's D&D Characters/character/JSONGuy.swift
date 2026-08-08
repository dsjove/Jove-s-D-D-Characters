import Foundation

/// Serialization fixture. Every optional Character-reachable property is intentionally populated
/// so exported JSON demonstrates the complete Codable schema rather than a typical sparse character.
public let JSONGuy = Character(
	person: .init(
		identity: .init(
			"JSON Guy",
			player: "Schema Tester",
			orientation: .init(bioSex: .man, gender: .male, pronouns: .he),
			ancestry: "Human",
			creatureType: .humanoid,
			size: .medium,
			classes: [.init("Wizard", specialty: "School of Evocation", level: 5)],
			alignment: .init(.neutral, .good)
		),
		appearance: .init(
			age: .init(30, .year),
			height: .init(70, .inch),
			weight: .init(175, .pound),
			build: "Average",
			skin: "Tan",
			eyes: "Brown",
			hair: "Brown",
			portrait: "json_guy_portrait"
		),
		background: .init("Sage", organization: "Schema Guild", role: "Archivist", clearance: "Full"),
		personality: .init(
			traits: ["Methodical"], ideals: ["Completeness"], bonds: ["The schema"], flaws: ["Overdocuments"], manner: ["Enumerates everything"]
		),
		relationships: [.init("Key Value", role: "Colleague", detail: "Checks serialization output.")],
		associatedCreatures: [
			.init(
				"Nested Guy",
				kind: .familiar,
				statBlock: .init(
					armorClass: 12,
					health: .init(maxHitPoints: 10, hitPoints: 0, hitDice: [.init(2, .d4)], remainingHitDice: [.init(1, .d4)], temporaryHitPoints: 1, deathSaveSuccesses: 1, deathSaveFailures: 1, isStable: true),
					abilities: [.init(.strength, score: 8, modifier: -1, savingThrow: -1)],
					speeds: [.init(.walking, feet: 30)],
					attacks: [
						.init(
							"Schema Bolt",
							source: .spell,
							delivery: .ranged,
							resolution: .savingThrow(ability: .dexterity, dc: 15, result: .halfDamage),
							ability: .intelligence,
							isProficient: true,
							attackBonus: 7,
							range: .init(.distance, normal: .init(30, .foot), long: .init(120, .foot)),
							target: .init(.area, count: 1, area: .init(.line, size: .init(30, .foot), width: .init(5, .foot)), restrictions: "Visible target"),
							damage: [.init(.init(2, .d6, 1), type: .force, timing: .immediate, appliesAbilityModifier: true, condition: "On failed save")],
							criticalThreshold: 19,
							properties: [.magical, .special],
							effects: [.init(trigger: .onFailedSave, condition: .prone, duration: .rounds(1), savingThrow: .init(ability: .strength, dc: 14, timing: .endOfTurn, success: .endsEffect), description: "Exercises every effect field.")],
							notes: "Exercises every attack field."
						)
					],
					features: [.init("Nested Feature", source: "Fixture", counter: .init(recharge: .shortRest, maximum: 2, used: 1, suffix: "uses"), detail: "Nested feature detail")],
					notes: ["Nested stat block note"]
				),
				notes: ["Associated creature note"]
			)
		],
		backstory: .init("Backstory", [.init("Origin", "Created to test JSON export."), .init("Goal", "Expose every stored key.")])
	),
	life: .init(
		health: .init(maxHitPoints: 38, hitPoints: 30, hitDice: [.init(5, .d6)], remainingHitDice: [.init(3, .d6)], temporaryHitPoints: 4, deathSaveSuccesses: 0, deathSaveFailures: 0, isStable: false),
		abilities: [
			.init(.strength, score: 8, modifier: -1, savingThrow: -1),
			.init(.dexterity, score: 14, modifier: 2, savingThrow: 2),
			.init(.constitution, score: 14, modifier: 2, savingThrow: 2),
			.init(.intelligence, score: 18, modifier: 4, savingThrow: 7),
			.init(.wisdom, score: 12, modifier: 1, savingThrow: 4),
			.init(.charisma, score: 10, modifier: 0, savingThrow: 0),
		],
		combat: [.init(.armorClass, score: 15), .init(.initiative, score: 2), .init(.proficiencyBonus, score: 3), .init(.passivePerception, score: 14), .init(.inspiration, score: 1)],
		defenses: .init(damageResistances: [.fire], vulnerabilities: [.cold], damageImmunities: [.poison], conditionImmunities: [.charmed], notes: ["Defense note"]),
		movementAndSenses: .init(speeds: [.init(.walking, feet: 30)], senses: [.init(.darkvision, range: .init(60, .foot), detail: "Sense detail")], notes: ["Movement note"]),
		currentConditions: .init(conditions: [.grappled], exhaustion: 1, persistentEffects: ["Persistent effect"], concentration: "Detect Magic")
	),
	capabilities: .init(
		attacks: [.init("Quarterstaff", source: .weapon, delivery: .melee, resolution: .attackRoll, ability: .strength, isProficient: true, attackBonus: 2, range: .init(.reach, normal: .init(5, .foot), long: .init(10, .foot)), target: .init(.creature, count: 1, area: .init(.sphere, size: .init(1, .foot), width: .init(1, .foot)), restrictions: "Schema-only populated area"), damage: [.init(.init(1, .d6), type: .bludgeoning, timing: .onHit, appliesAbilityModifier: true, condition: "Normal hit")], criticalThreshold: 20, properties: [.versatile], effects: [.init(trigger: .onHit, condition: .stunned, duration: .minutes(1), savingThrow: .init(ability: .constitution, dc: 13, timing: .whenApplied, success: .noEffect), description: "Fixture effect")], notes: "Attack note")],
		skills: [.init(.arcana, modifier: 7, mark: .proficient)],
		features: [.init("Arcane Recovery", source: "Wizard", counter: .init(recharge: .longRest, maximum: 1, used: 0, suffix: "use"), detail: "Feature detail")],
		spellcasting: [.init("Wizard", tradition: .arcane, ability: .intelligence, spellSaveDC: 15, spellAttackBonus: 7, slots: [.init(.first, maximum: 4, used: 1, recharge: .longRest)], spells: [.init("Detect Magic", level: .first, school: "Divination", preparation: .prepared, castingTime: "1 action", range: "Self", components: ["V", "S"], duration: "10 minutes", ritual: true, concentration: true, isPrepared: true, detail: "Spell detail")], focus: "Crystal", notes: ["Spellcasting note"])],
		maneuverSaveDC: 15,
		maneuvers: [.init("Fixture Maneuver", detail: "Maneuver detail")],
		proficiencies: .init(savingThrows: [.intelligence, .wisdom], languages: ["Common"], tools: ["Calligrapher's supplies"], armor: ["Light armor"], weapons: ["Daggers"], expertise: ["Arcana"], other: [.init("Other Proficiency", [.init("Subtype", "Detail")])]),
		resources: [.init("Fixture Resource", counter: .init(recharge: .oncePerDay, maximum: 3, used: 1, suffix: "points"), notes: ["Resource note"])]
	),
	possessions: .init(
		equipment: [.init("Fixture Armor", location: .equipped, quantity: 1, unitWeight: .init(10, .pound), armorContribution: 2, attunement: .attuned, charges: .init(recharge: .dawn, maximum: 3, used: 1, suffix: "charges"), isConsumable: false, notes: ["Equipment note"])],
		moneys: .init(copper: 1, silver: 2, electrum: 3, gold: 4, platinum: 5),
		valuables: .init([.init("Fixture Gem", "Valuable detail", itemCount: 2, .gold, 25)]),
		encumbrance: .init(carryingCapacity: .init(120, .pound), carriedWeight: .init(55, .pound), state: .unencumbered)
	),
	advancement: .init(method: .experience, currentExperience: 6_500, nextLevelExperience: 14_000, milestoneProgress: "One of two", feats: ["Alert"], abilityScoreImprovements: ["Intelligence +2"], notes: ["Advancement note"]),
	notes: .init(dashboard: [.init("Dashboard", [.init("Key", "Value")])], reminders: ["Reminder"], campaign: ["Campaign note"])
)
