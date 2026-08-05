import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func conditions(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.currentConditions
	if !value.isEmpty {
		modelSection(theme, "Current Conditions", fields: [
			.init("Conditions", sheetList(value.conditions.map(\.description))),
			.init("Exhaustion", value.exhaustion == 0 ? nil : value.exhaustion.description),
			.init("Concentration", value.concentration),
			.init("Persistent Effects", value.persistentEffects.filter { !$0.isEmpty }.joined(separator: "; ")),
		], dimension)
	}
}
