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
					.init(.intrinsic(), gap: 20),
					.init(.intrinsic(), gap: 20),
					.init(.intrinsic(), gap: 20),
					.init(.intrinsic(), gap: 20),
					.init(dimension, gap: 20),
				]
				Grid(table: columns) {
					jargon.attackSections.map {
						JCSText($0, font: theme.proficiencyLineFont, color: theme.ink)
					}
					c.capabilities.attacks.map { attack in
						[
							JCSText(
								attack.name,
								font: theme.proficiencyLineFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetResolutionDescription(jargon: jargon),
								font: theme.pageHeaderSubtitleFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDamageDescription(jargon: jargon),
								font: theme.proficiencyLineFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDeliveryDescription(jargon: jargon),
								font: theme.proficiencyLineFont,
								color: theme.ink
							),
							JCSText(
								attack.sheetDetailDescription(jargon: jargon),
								font: theme.maneuverBodyFont,
								color: theme.ink
							),
						]
					}
					.flatMap { $0 }
				}
				render: { theme.lineSeperator($0) }
			}
		}
	}
}
