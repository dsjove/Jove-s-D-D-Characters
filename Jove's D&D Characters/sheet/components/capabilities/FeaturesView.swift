import Foundation
import SBJLayout

//TODO: better content display in row
@JCSLayoutElementBuilder
func features(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.capabilities.features.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.featuresTitle)
			Panel(theme) {
				Grid(vertFlow: .init(dimension)) {
					c.capabilities.features.filter { !$0.isEmpty }.map { item in [
						JCSText([item.name, item.source].filter { !$0.isEmpty }.joined(separator: " — "), theme, font: .lineItemBold),
						JCSText(item.detail, theme),
						JCSText(item.counter, theme),
					]}
				}
				rowRender: { theme.rowLineSeperator($0, 3) }
			}
		}
	}
}
