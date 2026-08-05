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
					c.capabilities.features.map { item in [
						JCSText(item.name + item.source, font: theme.featureHeadingFont, color: theme.ink),
						JCSText(item.detail, font: theme.featureBodyFont, color: theme.ink),
						JCSText(item.counter?.description, font: theme.featureBodyFont, color: theme.ink),
					]}.flatMap({$0})
				}
				render: { theme.lineSeperator($0) }
			}
		}
	}
}
