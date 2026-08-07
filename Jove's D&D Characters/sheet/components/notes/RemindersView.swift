import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func reminders(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if !c.notes.reminders.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.remindersTitle)
			Panel(theme) {
				Grid(vertFlow: .init(dimension, align: .left), rows: .init(align: .centerY)) {
					c.notes.reminders.map { item in
						JCSText("\(jargon.reminderMarker) \(item)", theme, font: .lineItemBold, lines: 0...2)
					}
				}
				render: { theme.rowLineSeperator($0) }
			}
		}
	}
}
