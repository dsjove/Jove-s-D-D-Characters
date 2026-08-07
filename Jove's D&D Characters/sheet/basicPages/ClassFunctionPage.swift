import SBJLayout

struct ClassFunctionPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.capabilities.spellcasting.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		PageTitle(theme, "Class Functions")
		reusableResources(c, theme, jargon)
		maneuvers(c, theme, jargon)
		spellcasting(c, theme, jargon)
	}
}
