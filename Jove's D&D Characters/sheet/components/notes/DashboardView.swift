import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func dashboard(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.notes.dashboard.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.dashboardTitle)
			Grid(horzFlow: .init(dimension)) {
				c.notes.dashboard.filter { !$0.isEmpty }.map { item in
					Panel(theme) {
						Grid(vertFlow: .init(dimension)) {
							JCSText(item.name, theme, font: .lineItemBold, align: .centerBottom, lines: 1...1)
							Grid(table: [.init(.intrinsic()), .init(dimension)]) {
								item.sections.filter { !$0.isEmpty }.map { [
									JCSText($0.title + jargon.labelSeparator, theme, font: .lineItemBold, lines: 1...1),
									JCSText($0.body, theme, lines: 0...2)
								] }
							}
						}
					}
				}
			}
		}
	}
}
