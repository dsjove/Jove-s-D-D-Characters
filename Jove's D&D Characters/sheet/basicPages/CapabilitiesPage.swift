import SBJLayout

struct CapabilitiesPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.person.relationships.isEffectivelyEmpty &&
		c.person.associatedCreatures.isEffectivelyEmpty &&
		c.capabilities.skills.isEffectivelyEmpty &&
		c.capabilities.features.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func doDraw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, "Capabilities & Companions")
			relationships(c, theme, jargon)
			associatedCreatures(c, theme, jargon)
			Grid(cols: [.init(gap: theme.sectionGap), .init(.fill())]) {
				skills(c, theme, jargon)
				features(c, theme, jargon)
			}
		}
	}
}
