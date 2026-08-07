import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func attacks(
	_ c: Character,
	_ theme: any Theme,
	_ jargon: any Jargon,
	_ dimension: TrackSize = .fill()
) -> JCSLayoutElements {
	if c.capabilities.attacks.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.attacksTitle)
			Panel(theme) {
				let columns: [Track] = [
					.init(.intrinsic(), gap: 5),
					.init(.intrinsic(), gap: 5),
					.init(dimension, gap: 5),
					.init(dimension, gap: 5),
					.init(dimension, gap: 5),
				]
				Grid(table: columns) {
					jargon.attackSections.map {
						JCSText($0, font: theme.proficiencyLineFont, color: theme.ink)
					}
					c.capabilities.attacks.map { attack in
						[
							JCSText(
								attack.name.multiLineDescription,
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetResolutionDescription(jargon: jargon),
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDamageDescription(jargon: jargon),
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDeliveryDescription(jargon: jargon),
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDetailDescription(jargon: jargon),
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}
