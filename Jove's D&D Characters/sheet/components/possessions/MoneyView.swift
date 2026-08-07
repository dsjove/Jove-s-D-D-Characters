import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func money(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.possessions.moneys
	if !value.isEmpty {
		modelSection(theme, "Money", fields: [SheetField("Currency", value.description)], dimension)
	}
}

@JCSLayoutElementBuilder
func money2(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let values = c.possessions.moneys.values
	let fields = values.map {
		SheetField($0.0.description, $0.1.description)
	}
	modelSection(theme, "Money", fields: fields, align: .rightCenter, dimension)
}
