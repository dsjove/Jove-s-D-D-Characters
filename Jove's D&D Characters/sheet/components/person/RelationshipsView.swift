import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func relationships(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.person.relationships.filter { !$0.isEmpty }
	if !values.isEmpty {
		modelSection(theme, jargon.relationshipsTitle, fields: values.map {
			.init([$0.name, $0.role].filter { !$0.isEmpty }.joined(separator: " — "), $0.detail)
		}, dimension)
	}
}
