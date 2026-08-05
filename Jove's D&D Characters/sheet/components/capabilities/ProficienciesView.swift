import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func proficiencies(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.capabilities.proficiencies
	if !value.isEmpty {
		modelSection(theme, jargon.proficienciesTitle, fields: fields(value), dimension)
	}
}

func fields(_ value: Proficiencies) -> [SheetField] {
	var fields: [SheetField] = [
		.init("Saving Throws", sheetList(value.savingThrows.map(\.description))),
		.init("Languages", sheetList(value.languages)),
		.init("Tools", sheetList(value.tools)),
		.init("Armor", sheetList(value.armor)),
		.init("Weapons", sheetList(value.weapons)),
		.init("Expertise", sheetList(value.expertise)),
	]
	fields.append(contentsOf: value.other.filter { !$0.isEmpty }.map { section in
		SheetField(
			section.name,
			section.sections.filter { !$0.isEmpty }.map {
				[$0.title, $0.body].filter { !$0.isEmpty }.joined(separator: ": ")
			}.joined(separator: "; ")
		)
	})
	return fields
}
