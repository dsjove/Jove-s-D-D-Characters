import SBJLayout

struct ClassFunctionPage: PagedContent {
	func isEmpty(_ c: Character) -> Bool {
		c.capabilities.resources.isEffectivelyEmpty &&
		c.capabilities.maneuvers.isEffectivelyEmpty &&
		c.capabilities.maneuverSaveDC == nil &&
		c.capabilities.spellcasting.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func layout(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		PageTitle(theme, "Class Functions")
		reusableResources(c, theme, jargon)
		maneuvers(c, theme, jargon)
		spellcasting(c, theme, jargon)
	}
}
