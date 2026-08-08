import SBJLayout

struct InventoryPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.possessions.isEmpty && c.person.associatedCreatures.isEffectivelyEmpty && c.person.relationships.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.inventoryTitle)
			equipment(c, theme, jargon)
			if !c.possessions.moneys.isEmpty || !c.possessions.valuables.isEmpty {
				Grid(table: [.init(gap: theme.sectionGap), .init(.fill())]) {
					money(c, theme, jargon, .intrinsic())
					valuables(c, theme, jargon)
				}
			}
			associatedCreatures(c, theme, jargon)
			relationships(c, theme, jargon)
		}
	}
}
