import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func campaignNotes(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.notes.campaign.filter { !$0.isEmpty }
	if !values.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.campaignNotesTitle)
			Panel(theme) {
				let h = JCSText(size: theme.font(.lineItem), lines: 1).measure().height
				Grid(vertFlow: .init(dimension), rows: .init(.intrinsic(min: h), minCount: 8)) {
					values.map {
						JCSText($0, theme, font: .lineItem, color: .ink, lines: 1...1)
					}
				}
				render: { theme.rowLineSeperator($0) }
			}
		}
	}
}
