import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func healthDetails(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.health
	if !value.isEmpty {
//		let deathSaves = value.deathSaveSuccesses == 0 && value.deathSaveFailures == 0
//			? nil
//			: "Successes \(value.deathSaveSuccesses) • Failures \(value.deathSaveFailures)"
//		modelSection(theme, "Health Details", fields: [
//			.init("Death Saves", deathSaves),
//		], dimension)
		SectionTitle(theme, "Heath")
		let columns: [Track] = (0..<6).map { _ in
				.init(.uniform(), align: .centerTop)
			}
		Grid(table: columns, rows: .init(.uniform())) {
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
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Hit Dice", theme, font: .lineItemBold)
					JCSText(value.hitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .body, lines: 1...1)
					JCSText("Remaining", theme, font: .lineItemBold)
					JCSText(value.remainingHitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Death\nSaves", theme, font: .lineItemBold)
					JCSText("S\(value.success.description)", theme, font: .body)
					JCSText("F\(value.failures.description)", theme, font: .body)
				}
			}
		}
	}
}
