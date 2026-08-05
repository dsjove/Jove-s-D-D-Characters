import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func money(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.possessions.moneys
	if !value.isEmpty {
		modelSection(theme, "Money", fields: [SheetField("Currency", value.description)], dimension)
	}
}
