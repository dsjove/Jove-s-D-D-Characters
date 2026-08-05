import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func defenses(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.defenses
	if !value.isEmpty {
		modelSection(theme, "Defenses", fields: [
			.init("Resistances", sheetList(value.damageResistances.map(\.description))),
			.init("Vulnerabilities", sheetList(value.vulnerabilities.map(\.description))),
			.init("Damage Immunities", sheetList(value.damageImmunities.map(\.description))),
			.init("Condition Immunities", sheetList(value.conditionImmunities.map(\.description))),
			.init("Notes", value.notes.filter { !$0.isEmpty }.joined(separator: "; ")),
		], dimension)
	}
}
