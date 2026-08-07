import SBJLayout

struct CapabilitiesPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		false
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, "Capabilities")
			movementAndSenses(c, theme, jargon)
			defenses(c, theme, jargon)
			proficiencies(c, theme, jargon)
			Grid(table: [.init(gap: theme.sectionGap), .init(.fill())]) {
				skills(c, theme, jargon)
				features(c, theme, jargon)
			}
		}
	}
}
