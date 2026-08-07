import SBJLayout

struct CombatPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.life.combat.isEffectivelyEmpty &&
		c.life.abilities.isEffectivelyEmpty &&
		c.capabilities.attacks.isEffectivelyEmpty &&
		c.capabilities.maneuvers.isEffectivelyEmpty &&
		c.capabilities.resources.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, c.person.identity.name, c.person.identity.sheetSummary)
			combat(c, theme, jargon)
			abilityScores(c, theme, jargon)
			attacks(c, theme, jargon)
		}
	}
}
