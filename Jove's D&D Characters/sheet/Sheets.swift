import Foundation

let BasicSheet = Sheet(
	name: "Basic", pages: [
		CombatPage(),
		CapabilitiesPage(),
		ClassFunctionPage(),
		QuickReferencePage(),
		InventoryPage(),
		DossierPage(),
	]
)

let Sheets: [Sheet] = [BasicSheet]
