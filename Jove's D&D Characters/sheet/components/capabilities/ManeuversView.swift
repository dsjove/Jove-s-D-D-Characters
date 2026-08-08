import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func maneuvers(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.capabilities.maneuvers.hasContent || c.capabilities.maneuverSaveDC != nil {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, [jargon.maneuverTitle, c.capabilities.maneuverSaveDC.map { "Save DC \($0)" }].compactMap { $0 }.joined(separator: " • "))
			Grid(horzFlow: .init(.fill()), wrapped: 3) {
				c.capabilities.maneuvers.filter { !$0.isEmpty }.map { item in
					Panel(theme) {
						Grid(vertFlow: .init(.fill())) {
							JCSText(item.name, theme, font: .lineItemBold, align: .centerBottom, lines: 0...1)
							JCSText(item.detail, theme, lines: 0...3)
						}
						rowRender: { theme.rowLineSeperator($0) }
					}
				}
			}
		}
	}
}
