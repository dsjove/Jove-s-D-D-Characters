import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func campaignNotes(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.notes.campaign.filter { !$0.isEmpty }
	if !values.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.campaignNotesTitle)
			Panel(theme) {
				Grid(vertFlow: .init(dimension), rows: .init(min: 8)) {
					values.map { JCSText($0, font: theme.skillNameFont, lines: 1) }
					(0..<max(0, 8 - values.count)).map { _ in JCSText(nil, font: theme.skillNameFont, lines: 1) }
				}
				render: { theme.lineSeperator($0) }
			}
		}
	}
}
