import SBJLayout

struct CombatGroup: SheetGroupContent {
	func isEmpty(_ c: Character) -> Bool {
		c.person.identity.isEmpty &&
		c.life.health.isEmpty &&
		c.life.abilities.isEffectivelyEmpty &&
		c.life.combat.isEffectivelyEmpty &&
		c.life.currentConditions.isEmpty &&
		c.capabilities.attacks.isEffectivelyEmpty
	}

	@JCSLayoutElementBuilder
	func layout(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		PageTitle(theme, c.person.identity.name, c.person.identity.sheetSummary)
		coreStats(c, theme, jargon)
		healthDetails(c, theme, jargon)
		attacks(c, theme, jargon)
	}
}
