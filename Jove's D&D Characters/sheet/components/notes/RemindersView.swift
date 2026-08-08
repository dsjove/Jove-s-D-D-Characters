import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func reminders(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.notes.reminders.filter { !$0.isEmpty }
	if !values.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.remindersTitle)
			Panel(theme) {
				Grid(vertFlow: .init(dimension, align: .left), rows: .init(align: .centerY)) {
					values.map { item in
						JCSText("\(jargon.reminderMarker) \(item)", theme, font: .lineItemBold, lines: 0...2)
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}
