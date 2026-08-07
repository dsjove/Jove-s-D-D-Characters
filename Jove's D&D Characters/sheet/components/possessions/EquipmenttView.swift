import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func equipment(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.possessions.equipment.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, jargon.equipmentTitle)
			Panel(theme) {
				Grid(table: [
					.init(.intrinsic(), gap: 6),
					.init(.intrinsic(), align: .center, gap: 6),
					.init(.intrinsic(), gap: 6),
					.init(.intrinsic(), gap: 6)],
				rows: .init(align: .leftCenter)) {
					[
						JCSText("Item", font: theme.proficiencyLineFont, color: theme.ink),
						JCSText("Qty", font: theme.proficiencyLineFont, color: theme.ink),
						JCSText("Location", font: theme.proficiencyLineFont, color: theme.ink),
						JCSText("Description", font: theme.proficiencyLineFont, color: theme.ink),
					]
					c.possessions.equipment.map { item in
						let state = [
							item.totalWeight?.description,
							item.attunement == .notRequired ? nil : item.attunement.description,
							item.charges?.description,
							item.isConsumable ? "Consumable" : nil,
						].compactMap { $0 }.joined(separator: " • ")
						return [
							JCSText(item.name + (item.notes.isEmpty ? "" : "\n" + item.notes.joined(separator: "; ")), font: theme.smallNoteBoldFont, color: theme.ink, maxLines: 3),
							JCSText(item.quantity.description, font: theme.featureBodyFont, color: theme.ink),
							JCSText(item.location.description, font: theme.featureBodyFont, color: theme.ink),
							JCSText(state, font: theme.featureBodyFont, color: theme.ink, maxLines: 2),
						]
					}
				}
				rowRender: { theme.rowLineSeperator($0) }
				colRender: { theme.colLineSeperator($0) }
			}
		}
	}
}
