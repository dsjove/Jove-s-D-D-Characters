import SBJLayout

struct QuickReferenceGroup: SheetGroupContent {
	func isEmpty(_ c: Character) -> Bool {
		c.notes.isEmpty
	}

	@JCSLayoutElementBuilder
	func layout(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		PageTitle(theme, jargon.quickReferenceTitle)
		dashboard(c, theme, jargon)
		reminders(c, theme, jargon)
		campaignNotes(c, theme, jargon)
	}
}
