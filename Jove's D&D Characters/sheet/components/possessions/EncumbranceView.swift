import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func encumbrance(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.possessions.encumbrance
	if !value.isEmpty {
		modelSection(theme, "Encumbrance", fields: [
			SheetField("Carried", value.carriedWeight?.description),
			SheetField("Capacity", value.carryingCapacity?.description),
			SheetField("State", value.state?.description),
		], dimension)
	}
}
