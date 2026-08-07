import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func valuables(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if !c.possessions.valuables.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, "Valuables")
			Panel(theme) {
				Grid(table: [.init(.intrinsic(), gap: 16), .init(dimension)], rows: .init(align: .leftCenter)) {
					c.possessions.valuables.items.map { item in [
						JCSText(item.description, font: theme.smallNoteBoldFont, color: theme.ink),
						JCSText(item.detail, font: theme.featureBodyFont, color: theme.ink, maxLines: 3),
					] }
				}
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}
