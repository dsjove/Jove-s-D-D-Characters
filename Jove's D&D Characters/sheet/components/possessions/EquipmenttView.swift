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
						JCSText("Item", font: theme.proficiencyLineFont, color: theme.color(.ink)),
						JCSText("Qty", font: theme.proficiencyLineFont, color: theme.color(.ink)),
						JCSText("Location", font: theme.proficiencyLineFont, color: theme.color(.ink)),
						JCSText(" ", font: theme.proficiencyLineFont, color: theme.color(.ink)),
						JCSText(" "),
						JCSText(" "),
						JCSText(" "),
					]
					c.possessions.equipment.map { item in
						[
							JCSText(item.name + (item.notes.isEmpty ? "" : "\n" + item.notes.joined(separator: "; ")), font: theme.smallNoteBoldFont, color: theme.color(.ink), lines: 0...3),
							JCSText(item.quantity, font: theme.featureBodyFont, color: theme.color(.ink)),
							JCSText(item.location, font: theme.featureBodyFont, color: theme.color(.ink)),
							JCSText(item.totalWeight?.description, font: theme.featureBodyFont, color: theme.color(.ink)),
							JCSText(item.attunement == .notRequired ? nil : item.attunement, font: theme.featureBodyFont, color: theme.color(.ink)),
							JCSText(item.charges, font: theme.featureBodyFont, color: theme.color(.ink)),
							JCSText(item.isConsumable ? "Consumable" : nil, font: theme.featureBodyFont, color: theme.color(.ink)),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
				colRender: { theme.colLineSeperator($0) }
			}
		}
	}
}
