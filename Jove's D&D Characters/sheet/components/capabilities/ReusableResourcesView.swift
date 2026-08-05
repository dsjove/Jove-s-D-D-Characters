import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func reusableResources(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.capabilities.resources.filter { !$0.isEmpty }
	if !values.isEmpty {
		modelSection(theme, "Reusable Resources", fields: values.map {
			.init($0.name, [$0.counter.description, $0.notes.joined(separator: "; ")].filter { !$0.isEmpty }.joined(separator: " — "))
		}, dimension)
	}
}
