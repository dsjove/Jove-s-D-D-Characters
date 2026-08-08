import SBJLayout

struct ClassFunctionPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.capabilities.resources.isEffectivelyEmpty && c.capabilities.maneuvers.isEffectivelyEmpty && c.capabilities.maneuverSaveDC == nil && c.capabilities.spellcasting.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, "Class Functions")
			reusableResources(c, theme, jargon)
			maneuvers(c, theme, jargon)
			spellcasting(c, theme, jargon)
		}
	}
}
