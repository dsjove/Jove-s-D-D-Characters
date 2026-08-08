import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func appearance(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.person.appearance
	if !value.isEmpty {
		modelSection(theme, "Appearance", fields: [
			.init("Age", value.age?.description),
			.init("Height", value.height?.description),
			.init("Weight", value.weight?.description),
			.init("Build", value.build),
			.init("Skin", value.skin),
			.init("Eyes", value.eyes),
			.init("Hair", value.hair),
			.init("Portrait", value.portrait),
		], dimension)
	}
}
