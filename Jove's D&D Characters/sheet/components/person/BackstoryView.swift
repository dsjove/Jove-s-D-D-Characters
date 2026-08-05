import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func backstory(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.person.backstory
	if !value.isEmpty {
		modelSection(
			theme,
			value.name.isEmpty ? "Backstory" : value.name,
			fields: value.sections.filter { !$0.isEmpty }.map { .init($0.title, $0.body) },
			dimension
		)
	}
}
