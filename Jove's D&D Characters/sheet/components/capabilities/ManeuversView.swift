import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func maneuvers(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.capabilities.maneuvers.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.maneuverTitle)
			Grid(horzFlow: .init(.uniform())) {
				c.capabilities.maneuvers.map { item in
					Panel(theme) {
						Grid(vertFlow: .init(.intrinsic())) {
							JCSText(item.name, theme, font: .lineItemBold, align: .centerBottom, lines: 0...1)
							JCSText(item.detail, theme, lines: 0...3)
						}
					}
				}
			}
		}
	}
}
