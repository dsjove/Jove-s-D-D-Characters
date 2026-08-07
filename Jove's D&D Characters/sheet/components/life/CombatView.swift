import Foundation
import SBJLayout

//TODO: Do better...
@JCSLayoutElementBuilder
func combat(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.life.combat.hasContent {
		Grid(table: [.init(.fill(), align: .center), .init(align: .center)], rows: .init(aggregate: min)) {
			JCSImage(ImageSource.bundled(c.person.appearance.portrait, Bundle.main), cornerRadius: 8)
			let columns: [Track] = (0..<5).map { _ in
				.init(.uniform(), align: .centerTop)
			}
			Grid(table: columns, rows: .init(.uniform())) {
				c.life.combat[0...2].map { item in
					Panel(theme, aspectRatio: true) {
						Grid(vertFlow: .init(), rows: .init(align: .center)) {
							JCSText(item.stat.multiLineDescription, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 2...2)
							JCSText(item.score?.signedDescription(apply: item.isBonus), font: theme.largeAttributeFont, color: theme.color(.ink), lines: 1...1)
						}
					}
				}

				Panel(theme, aspectRatio: true) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText(jargon.maxHitPointsTitle, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 2...2)
						JCSText(c.life.health.maxHitPoints?.description, font: theme.largeAttributeFont, color: theme.color(.ink), lines: 1...1)
					}
				}
				Panel(theme, aspectRatio: true) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText(jargon.currentHitPointsTitle, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 2...2)
						JCSText(c.life.health.hitPoints?.description, font: theme.largeAttributeFont, color: theme.color(.ink), lines: 1...1)
					}
				}
				c.life.combat[3...5].map { item in
					Panel(theme, aspectRatio: true) {
						Grid(vertFlow: .init(), rows: .init(align: .center)) {
							JCSText(item.stat.multiLineDescription, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 2...2)
							JCSText(item.score?.signedDescription(apply: item.isBonus), font: theme.largeAttributeFont, color: theme.color(.ink), lines: 1...1)
						}
					}
				}
				Panel(theme, aspectRatio: true) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText(jargon.temporaryHitPointsTitle, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 1...2)
						JCSText(c.life.health.temporaryHitPoints?.description, font: theme.largeAttributeFont, color: theme.color(.ink), lines: 1...1)
					}
				}
				Panel(theme, aspectRatio: true) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText(jargon.deathSavesTitle, font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 2...2)
						JCSText("\(jargon.deathSaveSuccessTitle) \(String(repeating: jargon.deathSaveMarker, count: 3))\n\(jargon.deathSaveFailureTitle)\(jargon.labelSeparator) \(String(repeating: jargon.deathSaveMarker, count: 3))", font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 1...2)
					}
				}
			}
		}
	}
}
