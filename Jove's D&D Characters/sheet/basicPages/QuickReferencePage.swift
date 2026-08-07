import SBJLayout

struct QuickReferencePage: Page {
	func isEmpty(_ c: Character) -> Bool {
		false
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.quickReferenceTitle)
			dashboard(c, theme, jargon)
			reminders(c, theme, jargon)
			campaignNotes(c, theme, jargon)
		}
	}
}
