import Foundation

public struct Sheet {
	let name: String
	let pages: [Page]
}

public let Sheets: [Sheet] = [
	.init(name: "Basic", pages: [
		CombatPage(),
		SpellCasting(),
		QuickReferencePage(),
		InventoryPage(),
		ExplorationPage(),
		CapabilitiesPage(),
		DossierPage(),
	]),
	.init(name: "Other", pages: [
	]),
]
