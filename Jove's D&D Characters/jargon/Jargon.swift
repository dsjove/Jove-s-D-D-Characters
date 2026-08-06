import Foundation

public protocol Jargon: Sendable {
	var name: String { get }

	var abilitiesTitle: String { get }
	var dashboardTitle: String { get }
	var attacksTitle: String { get }
	var attackSections: [String] { get }
	var maneuverTitle: String { get }
	var skillsTitle: String { get }
	var featuresTitle: String { get }
	var proficienciesTitle: String { get }
	var remindersTitle: String { get }
	var equipmentTitle: String { get }
	var inventoryTitle: String { get }
	var quickReferenceTitle: String { get }
	var campaignNotesTitle: String { get }

	var maxHitPointsTitle: String { get }
	var currentHitPointsTitle: String { get }
	var temporaryHitPointsTitle: String { get }
	var deathSavesTitle: String { get }
	var deathSaveSuccessTitle: String { get }
	var deathSaveFailureTitle: String { get }
	var reminderMarker: String { get }
	var deathSaveMarker: String { get }
	var missingValueText: String { get }
	var labelSeparator: String { get }

	var dossierTitle: String { get }
	var identityTitle: String { get }
	var backgroundTitle: String { get }
	var collegeTitle: String { get }
	var statusTitle: String { get }
	var clearanceTitle: String { get }
	var personalityTitle: String { get }
	var traitsTitle: String { get }
	var idealsTitle: String { get }
	var bondsTitle: String { get }
	var flawsTitle: String { get }
	var mannerTitle: String { get }
	var artifactsTitle: String { get }
	var relationshipsTitle: String { get }

	var automaticTitle: String { get }
	var saveDCTitle: String { get }
	var reachTitle: String { get }
	var rangeTitle: String { get }
	var selfTitle: String { get }
	var sightTitle: String { get }
	var unlimitedTitle: String { get }
	var feetAbbreviation: String { get }
	var milesAbbreviation: String { get }
	var creatureTitle: String { get }
	var creaturesTitle: String { get }
	var objectTitle: String { get }
	var objectsTitle: String { get }
	var creatureOrObjectTitle: String { get }
	var creaturesOrObjectsTitle: String { get }
	var pointTitle: String { get }
	var areaTitle: String { get }
	var lineTitle: String { get }
	var cylinderTitle: String { get }
	var criticalOnTitle: String { get }
	var successTitle: String { get }
	var instantaneousTitle: String { get }
	var untilStartOfNextTurnTitle: String { get }
	var untilEndOfNextTurnTitle: String { get }
	var roundTitle: String { get }
	var roundsTitle: String { get }
	var minuteTitle: String { get }
	var minutesTitle: String { get }
	var hourTitle: String { get }
	var hoursTitle: String { get }
	var untilSaveSucceedsTitle: String { get }
	var permanentTitle: String { get }
}

public extension Jargon {
	var abilitiesTitle: String { "ABILITY SCORES & SAVING THROWS" }
	var dashboardTitle: String { "COMBAT DASHBOARD" }
	var attacksTitle: String { "Attacks" }
	var attackSections: [String] {
		[
			"Attack",
			"Bonus\nSave",
			"Damage",
			"Range/Target",
			"Properties/Effects",
		]
	}
	var maneuverTitle: String { "BATTLE MASTER MANEUVERS - 4d8 • SAVE DC 16 - Short Rest◯◯◯◯◯◯◯◯" }
	var skillsTitle: String { "Skills" }
	var featuresTitle: String { "Features" }
	var proficienciesTitle: String { "Proficiencies" }
	var remindersTitle: String { "Reminders" }
	var equipmentTitle: String { "Equipment" }
	var inventoryTitle: String { "Inventory" }
	var quickReferenceTitle: String { "Quick Reference" }
	var campaignNotesTitle: String { "Campaign Notes" }

	var maxHitPointsTitle: String { "Max HP" }
	var currentHitPointsTitle: String { "Current\nHP" }
	var temporaryHitPointsTitle: String { "Temp HP" }
	var deathSavesTitle: String { "Death\nSaves" }
	var deathSaveSuccessTitle: String { "S" }
	var deathSaveFailureTitle: String { "F" }
	var reminderMarker: String { "□" }
	var deathSaveMarker: String { "◯" }
	var missingValueText: String { "—" }
	var labelSeparator: String { ":" }

	var dossierTitle: String { "FIELD DOSSIER" }
	var identityTitle: String { "IDENTITY" }
	var backgroundTitle: String { "Background" }
	var collegeTitle: String { "College" }
	var statusTitle: String { "Status" }
	var clearanceTitle: String { "Clearance" }
	var personalityTitle: String { "Personality" }
	var traitsTitle: String { "TRAITS" }
	var idealsTitle: String { "IDEALS" }
	var bondsTitle: String { "BONDS" }
	var flawsTitle: String { "FLAWS" }
	var mannerTitle: String { "MANNER" }
	var artifactsTitle: String { "ARTIFACTS ENTRUSTED" }
	var relationshipsTitle: String { "Relationships" }

	var automaticTitle: String { "Automatic" }
	var saveDCTitle: String { "DC" }
	var reachTitle: String { "Reach" }
	var rangeTitle: String { "Range" }
	var selfTitle: String { "Self" }
	var sightTitle: String { "Sight" }
	var unlimitedTitle: String { "Unlimited" }
	var feetAbbreviation: String { "ft." }
	var milesAbbreviation: String { "mi." }
	var creatureTitle: String { "creature" }
	var creaturesTitle: String { "creatures" }
	var objectTitle: String { "object" }
	var objectsTitle: String { "objects" }
	var creatureOrObjectTitle: String { "creature/object" }
	var creaturesOrObjectsTitle: String { "creatures/objects" }
	var pointTitle: String { "point" }
	var areaTitle: String { "area" }
	var lineTitle: String { "line" }
	var cylinderTitle: String { "cylinder" }
	var criticalOnTitle: String { "Critical on" }
	var successTitle: String { "success" }
	var instantaneousTitle: String { "Instantaneous" }
	var untilStartOfNextTurnTitle: String { "Until start of next turn" }
	var untilEndOfNextTurnTitle: String { "Until end of next turn" }
	var roundTitle: String { "round" }
	var roundsTitle: String { "rounds" }
	var minuteTitle: String { "minute" }
	var minutesTitle: String { "minutes" }
	var hourTitle: String { "hour" }
	var hoursTitle: String { "hours" }
	var untilSaveSucceedsTitle: String { "Until save succeeds" }
	var permanentTitle: String { "Permanent" }
}


