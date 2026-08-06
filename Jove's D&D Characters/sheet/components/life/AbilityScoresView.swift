import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func abilityScores(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.life.abilities.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.abilitiesTitle)
			Grid(horzFlow: .init(align: .centerTop)) {
				c.life.abilities.map { item in
					Panel(theme, aspectRatio: true) {
						Grid(vertFlow: .init(.uniform()), rows: .init(align: .center)) {
							JCSText(item.ability.abbreviation, font: theme.sectionTitleFont, color: theme.ink, maxLines: 1)
							JCSText(item.score?.description ?? "", font: theme.largeAttributeFont, color: theme.ink, maxLines: 1)
							JCSText(item.sheetModMultiLineDescription, font: theme.smallNoteFont, color: theme.ink, lines: 2)
						}
					}
				}
			}
		}
	}
}
