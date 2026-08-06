import SBJLayout

struct QuickReferencePage: Page {
	func isEmpty(_ c: Character) -> Bool {
		c.notes.dashboard.isEffectivelyEmpty &&
		c.notes.reminders.isEmpty &&
		c.capabilities.proficiencies.isEmpty &&
		c.notes.campaign.isEmpty
	}

	@JCSLayoutElementBuilder
	func draw(_ c: Character, _ theme: Theme, _ jargon: any Jargon) -> JCSLayoutElements {
		if !isEmpty(c) {
			PageTitle(theme, jargon.quickReferenceTitle)
			dashboard(c, theme, jargon)
			reminders(c, theme, jargon)
			proficiencies(c, theme, jargon)
			campaignNotes(c, theme, jargon)
		}
	}
}
