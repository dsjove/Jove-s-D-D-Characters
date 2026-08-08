import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func healthDetails(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let health = c.life.health
	let conditions = c.life.currentConditions
	if !health.isEmpty || !conditions.isEmpty {
		SectionTitle(theme, "Health")
		Grid(horzFlow: .init(.uniform(), align: .centerTop), wrapped: 7, rows: .init(.uniform())) {
			//if health.maxHitPoints != nil {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("Max HP", theme, font: .lineItemBold)
						JCSText(health.maxHitPoints?.description, theme, font: .pageTitle, lines: 1...1)
					}
				}
			//}
			//if health.hitPoints != nil {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("HP", theme, font: .lineItemBold)
						JCSText(health.hitPoints?.description, theme, font: .pageTitle, lines: 1...1)
					}
				}
			//}
			//if health.temporaryHitPoints != nil {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("Temp HP", theme, font: .lineItemBold)
						JCSText(health.temporaryHitPoints?.description, theme, font: .pageTitle, lines: 1...1)
					}
				}
			//}
			//if health.hitPoints != nil || health.deathSaveSuccesses > 0 || health.deathSaveFailures > 0 || health.isStable || conditions.exhaustion > 0 {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
					//	if health.hitPoints != nil || health.deathSaveSuccesses > 0 || health.deathSaveFailures > 0 || health.isStable {
							JCSText(health.lifeState.description, theme, font: .lineItemBold)
							if health.isStable { JCSText("Stable", theme, font: .body, lines: 1...1) }
				//		}
						if conditions.exhaustion > 0 {
							JCSText("Exhaustion", theme, font: .lineItemBold)
							JCSText("\(conditions.exhaustion)", theme, font: .body, lines: 1...1)
						}
					}
				}
			//}
			if health.hitDice.hasContent || health.remainingHitDice.hasContent {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						if health.hitDice.hasContent {
							JCSText("Hit Dice", theme, font: .lineItemBold)
							JCSText(health.hitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .smallBody, lines: 1...1)
						}
						if health.remainingHitDice.hasContent {
							JCSText("Remaining", theme, font: .lineItemBold)
							JCSText(health.remainingHitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .smallBody, lines: 1...1)
						}
					}
				}
			}
			//if health.deathSaveSuccesses > 0 || health.deathSaveFailures > 0 || health.hitPoints == 0 {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("Death\nSaves", theme, font: .lineItemBold)
						JCSText("S\(health.success.description)", theme, font: .body)
						JCSText("F\(health.failures.description)", theme, font: .body)
					}
				}
			//}
			if !conditions.conditions.isEmpty {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("Conditions", theme, font: .lineItemBold)
						conditions.conditions.map { JCSText($0, theme, font: .body) }
					}
				}
			}
			if !conditions.concentration.isEmpty {
				OldPanel(theme) {
					Grid(vertFlow: .init(), rows: .init(align: .center)) {
						JCSText("Concen-\ntration", theme, font: .lineItemBold, lines: 2...2)
						JCSText(conditions.concentration, theme, font: .sectionTitle, lines: 1...1)
					}
				}
			}
		}
		modelSection(theme, "", fields: [
			.init("Persistent Effects", conditions.persistentEffects.filter { !$0.isEmpty }.joined(separator: "; ")),
		], dimension)
	}
}
