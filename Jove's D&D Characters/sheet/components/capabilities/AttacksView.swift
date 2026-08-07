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
						JCSText($0, theme, font: .sectionTitle, color: .ink)
					}
					c.capabilities.attacks.map { attack in
						[
							JCSText(
								attack.name.multiLineDescription,
								theme,
								font: .body,
								color: .ink
							),
							JCSText(
								attack.sheetResolutionDescription(jargon: jargon),
								theme,
								font: .body,
								color: .ink
							),
							JCSText(
								attack.sheetDamageDescription(jargon: jargon),
								theme,
								font: .body,
								color: .ink
							),
							JCSText(
								attack.sheetDeliveryDescription(jargon: jargon),
								theme,
								font: .body,
								color: .ink
							),
							JCSText(
								attack.sheetDetailDescription(jargon: jargon),
								theme,
								font: .body,
								color: .ink
							),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}

