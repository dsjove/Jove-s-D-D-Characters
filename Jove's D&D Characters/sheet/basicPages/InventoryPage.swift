import SBJLayout

struct InventoryPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		false
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.inventoryTitle)
			Grid(table: [.init(gap: theme.sectionGap), .init(.fill())]) {
				money2(c, theme, jargon, .intrinsic())
				equipment(c, theme, jargon)
			}
			valuables(c, theme, jargon)
			associatedCreatures(c, theme, jargon)
			relationships(c, theme, jargon)
		}
	}
}
