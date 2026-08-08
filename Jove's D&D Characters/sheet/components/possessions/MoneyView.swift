import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func money(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.possessions.moneys
	if !value.isEmpty {
		let fields = Currency.allCases.map { currency in
			SheetField(currency.description, value.values[currency, default: 0].description)
		}
		modelSection(theme, "Money", fields: fields, align: .rightCenter, dimension)
	}
}
