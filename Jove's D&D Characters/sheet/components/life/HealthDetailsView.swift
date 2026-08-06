import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func healthDetails(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.health
	if !value.isEmpty {
		let deathSaves = value.deathSaveSuccesses == 0 && value.deathSaveFailures == 0
			? nil
			: "Successes \(value.deathSaveSuccesses) • Failures \(value.deathSaveFailures)"
		modelSection(theme, "Health Details", fields: [
			.init("Life State", value.lifeState.description),
			.init("Hit Dice", value.hitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? ""),
			.init("Remaining Hit Dice", value.remainingHitDice?.filter { !$0.isEmpty }.map(\.description).joined(separator: ", ") ?? ""),
			.init("Death Saves", deathSaves),
			.init("Stable", value.isStable ? "Yes" : nil),
		], dimension)
	}
}
