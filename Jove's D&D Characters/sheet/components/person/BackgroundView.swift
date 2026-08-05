import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func background(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.person.background
	if !value.isEmpty {
		modelSection(theme, jargon.backgroundTitle, fields: [
			.init(jargon.backgroundTitle, value.name),
			.init(jargon.collegeTitle, value.organization),
			.init(jargon.statusTitle, value.role),
			.init(jargon.clearanceTitle, value.clearance),
		], dimension)
	}
}
