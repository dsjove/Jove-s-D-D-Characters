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
					JCSText("Max HP", theme, font: .body)
					JCSText(value.maxHitPoints?.description, theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("HP", theme, font: .body)
					JCSText(value.hitPoints?.description, theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Temp HP", theme, font: .body)
					JCSText(value.temporaryHitPoints?.description, theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText(value.lifeState.description, theme, font: .body)
					JCSText("Stable" + (value.isStable ? "Yes" : "No"), theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Hit Dice", theme, font: .body)
					JCSText(value.hitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .body, lines: 1...1)
					JCSText(value.remainingHitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? "", theme, font: .body, lines: 1...1)
				}
			}
			Panel(theme, aspectRatio: true) {
				Grid(vertFlow: .init(), rows: .init(align: .center)) {
					JCSText("Death Saves", theme, font: .body)
					JCSText("S\(value.deathSaveSuccesses)", theme, font: .body)
					JCSText("F\(value.deathSaveFailures)", theme, font: .body)
				}
			}
		}
	}
}
