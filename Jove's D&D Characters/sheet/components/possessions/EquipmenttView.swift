import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func equipment(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.possessions.equipment.hasContent || !c.possessions.encumbrance.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			let encumbranceSummary = c.possessions.encumbrance.isEmpty ? "" : " (\(c.possessions.encumbrance.description))"
			SectionTitle(theme, jargon.equipmentTitle + encumbranceSummary)
			if c.possessions.equipment.hasContent {
				Panel(theme) {
					Grid(
					table: [
						.init(.fill()),
						.init(.intrinsic(), align: .center),
						.init(.intrinsic(), align: .center),
						.init(.intrinsic()),
						.init(.intrinsic(), align: .center),
						.init(.intrinsic(), align: .center),
						.init(.intrinsic(), align: .center),
						.init(.intrinsic(), align: .center)],
					header: .init(),
					rows: .init(align: .leftCenter))
				{
					[
						JCSText("Item", theme, font: .lineItemBold),
						JCSText("Qty", theme, font: .lineItemBold),
						JCSText("Location", theme, font: .lineItemBold),
						JCSText("Weight", theme, font: .lineItemBold),
						JCSText("AC", theme, font: .lineItemBold),
						JCSText("Attuned", theme, font: .lineItemBold),
						JCSText("Charges", theme, font: .lineItemBold),
						JCSText("Consumable", theme, font: .lineItemBold),
					]
					c.possessions.equipment.filter { !$0.isEmpty }.map { item in
						[
							JCSText(item.name + (item.notes.isEmpty ? "" : "\n" + item.notes.joined(separator: "; ")), theme, lines: 0...3),
							JCSText(item.quantity.description, theme),
							JCSText(item.location, theme),
							JCSText(item.unitWeight.map { unit in item.quantity == 1 ? unit.description : "\(unit.description) ea / \(item.totalWeight?.description ?? "") total" }, theme),
							JCSText(item.armorContribution?.signedDescription(), theme),
							JCSText(item.attunement == .notRequired ? "N/R" : item.attunement.abbreviation, theme),
							JCSText(item.charges, theme),
							JCSText(item.isConsumable.map({$0 ? "●" : "○"}) ?? "", theme),
						]
					}
				}
				colRender: { theme.colLineSeperator($0) }
					rowRender: { theme.rowLineSeperator($0) }
				}
			}
		}
	}
}

