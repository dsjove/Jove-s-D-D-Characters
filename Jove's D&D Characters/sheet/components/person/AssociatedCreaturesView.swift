import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func associatedCreatures(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.person.associatedCreatures.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, "Associated Creatures")
			c.person.associatedCreatures.filter { !$0.isEmpty }.map { creature in
				Panel(theme) {
					let stats = creature.statBlock
					Grid(vertFlow: .init(dimension)) {
						JCSText("\(creature.name) — \(creature.kind.description)", theme, font: .lineItemBold)
						JCSText([
							stats?.armorClass.map { "AC \($0)" },
							stats?.health.maxHitPoints.map { "HP \($0)" },
							stats.map { $0.speeds.map { "\($0.mode.description) \($0.distance.description)" }.joined(separator: ", ") },
						].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " • "), theme)
						JCSText((creature.notes + (stats?.notes ?? [])).joined(separator: "; "), theme)
					}
					render: { theme.rowLineSeperator($0) }
				}
			}
		}
	}
}
