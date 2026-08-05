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
						JCSText(item.skill.description, font: (item.mark != .none ? theme.skillNameBoldFont : theme.skillNameFont), color: theme.ink),
						JCSText(item.modifier.signedDescription() + item.mark.description, font: (item.mark != .none ? theme.skillNameBoldFont : theme.skillNameFont), color: theme.ink),
						JCSText("(\(item.skill.ability.abbreviation))", font: theme.smallNoteFont, color: theme.ink)
					]}.flatMap({$0})
				}
				render: { theme.lineSeperator($0) }
			}
		}
	}
}
