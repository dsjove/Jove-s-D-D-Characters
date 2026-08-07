import SBJLayout

struct InventoryPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		false
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.inventoryTitle)
			equipment(c, theme, jargon)
			Grid(table: [.init(gap: theme.sectionGap), .init(.fill())]) {
				money2(c, theme, jargon, .intrinsic())
				valuables(c, theme, jargon)
			}
			associatedCreatures(c, theme, jargon)
			relationships(c, theme, jargon)
		}
	}
}
