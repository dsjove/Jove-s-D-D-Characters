import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func personality(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.person.personality
	if !value.isEmpty {
		modelSection(theme, jargon.personalityTitle, fields: [
			.init(jargon.traitsTitle, sheetList(value.traits)),
			.init(jargon.idealsTitle, sheetList(value.ideals)),
			.init(jargon.bondsTitle, sheetList(value.bonds)),
			.init(jargon.flawsTitle, sheetList(value.flaws)),
			.init(jargon.mannerTitle, sheetList(value.manner)),
		], dimension)
	}
}
