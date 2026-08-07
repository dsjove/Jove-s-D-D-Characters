import Foundation

public struct Sheet {
	let name: String
	let pages: [Page]
}

public let Sheets: [Sheet] = [
	.init(name: "Basic", pages: [
		CombatPage(),
		CapabilitiesPage(),
		ClassFunctionPage(),
		QuickReferencePage(),
		InventoryPage(),
		DossierPage(),
	]),
	.init(name: "Other", pages: [
	]),
]
