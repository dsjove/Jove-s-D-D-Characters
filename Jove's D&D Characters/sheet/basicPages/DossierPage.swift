import Foundation
import SBJLayout

struct DossierPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.person.identity.isEmpty && c.person.appearance.isEmpty && c.person.background.isEmpty && c.person.personality.isEmpty && c.person.backstory.isEmpty && c.advancement.isEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.dossierTitle)
			if !c.person.identity.isEmpty || !c.person.appearance.isEmpty {
				Grid(table: [.init(.fill(), gap: theme.sectionGap), .init(.fill())]) {
					identity(c, theme, jargon)
					appearance(c, theme, jargon)
				}
			}
			background(c, theme, jargon)
			personality(c, theme, jargon)
			backstory(c, theme, jargon)
			advancement(c, theme, jargon)
		}
	}
}
