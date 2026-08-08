import Foundation

let BasicSheet = Sheet(
	name: "Basic", content: [
		CombatGroup(),
		CapabilitiesGroup(),
		ClassFunctionGroup(),
		QuickReferenceGroup(),
		InventoryGroup(),
		DossierGroup(),
	]
)

let Sheets: [Sheet] = [BasicSheet]
