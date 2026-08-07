import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func equipment(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.possessions.equipment.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.equipmentTitle)
			Panel(theme) {
				Grid(table: [
					.init(.fill()),
					.init(.intrinsic(), align: .center),
					.init(.intrinsic(), align: .center),
					.init(.intrinsic()),
					.init(.intrinsic(), align: .center),
					.init(.intrinsic()),
					.init(.intrinsic())],
				rows: .init(align: .leftCenter)) {
					[
						JCSText("Item", theme, font: .lineItemBold),
						JCSText("Qty", theme, font: .lineItemBold),
						JCSText("Location", theme, font: .lineItemBold),
						JCSText(" ", theme, font: .lineItemBold),
						JCSText("Attuned", theme, font: .lineItemBold),
						JCSText(" "),
						JCSText(" "),
					]
					c.possessions.equipment.map { item in
						[
							JCSText(item.name + (item.notes.isEmpty ? "" : "\n" + item.notes.joined(separator: "; ")), theme, lines: 0...3),
							JCSText(item.quantity.description, theme),
							JCSText(item.location, theme),
							JCSText(item.totalWeight?.description, theme),
							JCSText(item.attunement.abbreviation, theme),
							JCSText(item.charges, theme),
							JCSText(item.isConsumable ? "Consumable" : nil, theme),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
				colRender: { theme.colLineSeperator($0) }
			}
		}
	}
}

