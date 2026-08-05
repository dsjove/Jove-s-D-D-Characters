import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func identity(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.person.identity
	if !value.isEmpty {
		modelSection(theme, jargon.identityTitle, fields: [
			.init("Name", value.name),
			.init("Ancestry", value.ancestry),
			.init("Classes", value.sheetClassesSummary),
			.init("Specialties", value.sheetSubclassSummary),
			.init("Alignment", value.alignment.isEmpty ? nil : value.alignment.description),
		], dimension)
	}
}
