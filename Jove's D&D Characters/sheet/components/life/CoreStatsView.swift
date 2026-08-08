import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func coreStats(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.life.abilities.hasContent || c.life.combat.hasContent || !c.person.appearance.portrait.isEmpty {
		Grid(table: [.init(.fill(), align: .center), .init(align: .center)], rows: .init(aggregate: {$0.last})) {
			JCSImage(ImageSource.bundled(c.person.appearance.portrait, Bundle.main), cornerRadius: 8)
			
			let abilities = c.life.abilities //.filter { !$0.isEmpty }
			let combat = c.life.combat //.filter { !$0.isEmpty }
			let columns: [Track] = (0..<6).map { _ in
				.init(.uniform(), align: .centerTop)
			}
			Grid(table: columns, rows: .init(.uniform())) {
				let occupied = (abilities.count + combat.count) % 6
				let remainder = occupied == 0 ? 0 : 6 - occupied
				abilities.map { item in
					OldPanel(theme) {
						Grid(vertFlow: .init(.uniform()), rows: .init(align: .center)) {
							JCSText(item.ability.abbreviation, theme, font: .lineItemBold)
							JCSText(item.score?.description ?? "", theme, font: .sectionTitle, lines: 1...1)
							JCSText(item.sheetModMultiLineDescription, theme, font: .smallBody, lines: 2...2)
						}
					}
				}
				combat.map { item in
					OldPanel(theme) {
						Grid(vertFlow: .init(), rows: .init(align: .center)) {
							JCSText(item.stat.multiLineDescription, theme, font: .lineItemBold, lines: 2...2)
							JCSText(item.score?.signedDescription(apply: item.isBonus), theme, font: .sectionTitle, lines: 1...1)
						}
					}
				}
				(0..<remainder).map { _ in
					OldPanel(theme) {
					}
				}
			}
		}
	}
}
