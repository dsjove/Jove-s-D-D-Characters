import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func skills(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .intrinsic()) -> JCSLayoutElements {
	if c.capabilities.skills.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.skillsTitle)
			Panel(theme) {
				let cols: [Track] = [
					.init(dimension, gap: 20),
					.init(.intrinsic(), gap: 20),
					.init(.intrinsic(), gap: 20),
				]
				Grid(table: cols, rows: .init(align: .leftCenter)) {
					c.capabilities.skills.map { item in [
						JCSText(item.skill, theme, font: (item.mark != .none ? .lineItemBold : .lineItem)),
						JCSText(item.modifier.signedDescription() + item.mark.description, theme, font: (item.mark != .none ? .lineItemBold : .lineItem)),
						JCSText("(\(item.skill.ability.abbreviation))", theme)
					]}
				}
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}
