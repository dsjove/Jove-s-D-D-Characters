import SBJLayout

struct InventoryPage: Page {
	func isEmpty(_ c: Character) -> Bool { c.possessions.isEmpty }

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.inventoryTitle)
			encumbrance(c, theme, jargon, .intrinsic())
			//Grid(horzFlow: .init(align: .centerTop)) {
				equipment(c, theme, jargon)
				money2(c, theme, jargon, .intrinsic())
			//}.id("fe")
			valuables(c, theme, jargon)
		}
	}
}
