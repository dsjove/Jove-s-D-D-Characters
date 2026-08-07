import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func equipment(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.possessions.equipment.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.equipmentTitle)
			Panel(theme) {
				Grid(table: [
					.init(.intrinsic()),
					.init(.intrinsic(), align: .center),
					.init(.intrinsic()),
					.init(.intrinsic()),
					.init(.intrinsic()),
					.init(.intrinsic()),
					.init(.intrinsic())],
				rows: .init(align: .leftCenter)) {
					[
						JCSText("Item", theme, font: .sectionTitle, color: .ink),
						JCSText("Qty", theme, font: .sectionTitle, color: .ink),
						JCSText("Location", theme, font: .sectionTitle, color: .ink),
						JCSText(" ", theme, font: .sectionTitle, color: .ink),
						JCSText(" "),
						JCSText(" "),
						JCSText(" "),
					]
					c.possessions.equipment.map { item in
						[
							JCSText(item.name + (item.notes.isEmpty ? "" : "\n" + item.notes.joined(separator: "; ")), theme, font: .lineItemBold, color: .ink, lines: 0...3),
							JCSText(item.quantity.description, theme, font: .body, color: .ink),
							JCSText(item.location, theme, font: .body, color: .ink),
							JCSText(item.totalWeight?.description, theme, font: .body, color: .ink),
							JCSText(item.attunement == .notRequired ? nil : item.attunement, theme, font: .body, color: .ink),
							JCSText(item.charges, theme, font: .body, color: .ink),
							JCSText(item.isConsumable ? "Consumable" : nil, theme, font: .body, color: .ink),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
				colRender: { theme.colLineSeperator($0) }
			}
		}
	}
}

