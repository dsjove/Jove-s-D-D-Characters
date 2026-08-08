import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func advancement(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.advancement
	if !value.isEmpty {
		modelSection(theme, "Advancement", fields: [
			.init("Method", value.method?.description),
			.init("Experience", value.currentExperience?.description),
			.init("Next Level XP", value.nextLevelExperience?.description),
			.init("Milestone", value.milestoneProgress),
			.init("Feats", sheetList(value.feats)),
			.init("Ability Improvements", sheetList(value.abilityScoreImprovements)),
			.init("Notes", value.notes.joined(separator: "; ")),
		], dimension)
	}
}
