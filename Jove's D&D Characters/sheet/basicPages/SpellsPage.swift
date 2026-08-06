import SBJLayout

struct SpellCasting: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.capabilities.spellcasting.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, "Spells")
			spellcasting(c, theme, jargon)
		}
	}
}
