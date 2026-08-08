import Foundation

public struct Sheet {
	let name: String
	let pages: [Page]
}

public let BasicSheet = Sheet(
	name: "Basic", pages: [
		CombatPage(),
		CapabilitiesPage(),
		ClassFunctionPage(),
		QuickReferencePage(),
		InventoryPage(),
		DossierPage(),
	]
)

public let Sheets: [Sheet] = [BasicSheet]
