import Foundation
import SBJLayout

struct DossierPage: Page {
	func isEmpty(_ c: Character) -> Bool {
		false
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.dossierTitle)
			Grid(table: [.init(.fill(), gap: theme.sectionGap), .init(.fill())]) {
				identity(c, theme, jargon)
				appearance(c, theme, jargon)
			}
			background(c, theme, jargon)
			personality(c, theme, jargon)
			backstory(c, theme, jargon)
			advancement(c, theme, jargon)
		}
	}
}
