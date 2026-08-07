import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func coreStats(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.life.combat.hasContent {
		Grid(table: [.init(.fill(), align: .center), .init(align: .center)], rows: .init(aggregate: {$0.min()})) {
			JCSImage(ImageSource.bundled(c.person.appearance.portrait, Bundle.main), cornerRadius: 8)
			let columns: [Track] = (0..<6).map { _ in
				.init(.uniform(), align: .centerTop)
			}
			Grid(table: columns, rows: .init(.uniform())) {
				c.life.abilities.map { item in
					Panel(theme, aspectRatio: true) {
						Grid(vertFlow: .init(.uniform()), rows: .init(align: .center)) {
							JCSText(item.ability.abbreviation, theme, font: .lineItemBold)
							JCSText(item.score?.description ?? "", theme, font: .body, lines: 0...1)
							JCSText(item.sheetModMultiLineDescription, theme, font: .smallBody, lines: 2...2)
						}
					}
				}
				c.life.combat.map { item in
					Panel(theme, aspectRatio: true) {
						Grid(vertFlow: .init(), rows: .init(align: .center)) {
							JCSText(item.stat.multiLineDescription, theme, font: .lineItemBold)
							JCSText(item.score?.signedDescription(apply: item.isBonus), theme, font: .body, lines: 1...1)
						}
					}
				}
			}
		}
	}
}
