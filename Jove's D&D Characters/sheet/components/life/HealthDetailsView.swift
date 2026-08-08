import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func healthDetails(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.health
	if !value.isEmpty {
		SectionTitle(theme, "Heath")
		Grid(horzFlow: .init(.uniform(), align: .centerTop), rows: .init(.uniform())) {
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Max HP", theme, font: .lineItemBold)
					JCSText(value.maxHitPoints?.description, theme, font: .pageTitle, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("HP", theme, font: .lineItemBold)
					JCSText(value.hitPoints?.description, theme, font: .pageTitle, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Temp HP", theme, font: .lineItemBold)
					JCSText(value.temporaryHitPoints?.description, theme, font: .pageTitle, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText(value.lifeState.description, theme, font: .lineItemBold)
					JCSText(value.isStable ? "Stable" : "", theme, font: .body, lines: 1...1)
					if c.life.currentConditions.exhaustion > 0 {
						JCSText("Exhaustion", theme, font: .lineItemBold)
						JCSText("\(c.life.currentConditions.exhaustion)", theme, font: .body, lines: 1...1)
					}
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Hit Dice", theme, font: .lineItemBold)
					JCSText(value.hitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .smallBody, lines: 1...1)
					JCSText("Remaining", theme, font: .lineItemBold)
					JCSText(value.remainingHitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .smallBody, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Death\nSaves", theme, font: .lineItemBold)
					JCSText("S\(value.success.description)", theme, font: .body)
					JCSText("F\(value.failures.description)", theme, font: .body)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Contitions", theme, font: .lineItemBold)
					c.life.currentConditions.conditions.map {
						JCSText($0, theme, font: .body)
					}
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Concent", theme, font: .lineItemBold, lines: 2...2)
					JCSText(c.life.currentConditions.concentration, theme, font: .sectionTitle, lines: 1...1)
				}
			}
		}
		modelSection(theme, "", fields: [
			.init("Persistent Effects", c.life.currentConditions.persistentEffects.filter { !$0.isEmpty }.joined(separator: "; ")),
		], dimension)
	}
}
