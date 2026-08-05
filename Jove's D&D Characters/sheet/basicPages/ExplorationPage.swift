import SBJLayout

struct ExplorationPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.life.movementAndSenses.isEmpty &&
		c.life.defenses.isEmpty &&
		c.life.currentConditions.isEmpty &&
		c.life.health.isEmpty
	}

	@JCSLayoutElementBuilder
	func doDraw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, "Status & Exploration")
			movementAndSenses(c, theme, jargon)
			defenses(c, theme, jargon)
			conditions(c, theme, jargon)
			healthDetails(c, theme, jargon)
		}
	}
}

