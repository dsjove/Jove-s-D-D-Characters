import SBJLayout

struct CapabilitiesGroup: SheetGroupContent {
	func isEmpty(_ c: Character) -> Bool {
		c.life.movementAndSenses.isEmpty &&
		c.life.defenses.isEmpty &&
		c.capabilities.proficiencies.isEmpty &&
		c.capabilities.skills.isEffectivelyEmpty &&
		c.capabilities.features.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func layout(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		PageTitle(theme, "Capabilities")
		movementAndSenses(c, theme, jargon)
		defenses(c, theme, jargon)
		proficiencies(c, theme, jargon)
		if c.capabilities.skills.hasContent || c.capabilities.features.hasContent {
			Grid(table: [.init(gap: theme.sectionGap), .init(.fill())]) {
				skills(c, theme, jargon)
				features(c, theme, jargon)
			}
		}
	}
}
