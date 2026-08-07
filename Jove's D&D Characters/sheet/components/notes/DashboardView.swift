import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func dashboard(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.notes.dashboard.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.dashboardTitle)
			Grid(horzFlow: .init(dimension)) {
				c.notes.dashboard.map { item in
					Panel(theme) {
						Grid(vertFlow: .init(dimension)) {
							JCSText(item.name, font: theme.featureHeadingFont, color: theme.color(.ink), align: .centerBottom, lines: 1...1)
							Grid(table: [.init(.intrinsic()), .init(dimension)]) {
								item.sections.map { [
									JCSText($0.title + jargon.labelSeparator, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 1...1),
									JCSText($0.body, font: theme.maneuverBodyFont, color: theme.color(.ink), lines: 0...2)
								] }
							}
						}
					}
				}
			}
		}
	}
}
