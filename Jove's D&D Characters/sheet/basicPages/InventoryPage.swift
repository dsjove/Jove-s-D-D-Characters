import SBJLayout

struct InventoryPage: Page {
	func isEmpty(_ c: Character) -> Bool { c.possessions.isEmpty }

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.inventoryTitle)
			encumbrance(c, theme, jargon)
			equipment(c, theme, jargon)
			money(c, theme, jargon)
			valuables(c, theme, jargon)
		}
	}
}
