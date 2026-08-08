import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func associatedCreatures(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.person.associatedCreatures.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, "Associated Creatures")
			c.person.associatedCreatures.filter { !$0.isEmpty }.map { creature in
				OldPanel(theme) {
					let stats = creature.statBlock
					Grid(vertFlow: .init(dimension)) {
						JCSText("\(creature.name) — \(creature.kind.description)", theme, font: .lineItemBold)
						let hp: String? = {
							guard let stats else { return nil }
							switch (stats.health.hitPoints, stats.health.maxHitPoints) {
							case let (.some(current), .some(maximum)): return "HP \(current)/\(maximum)"
							case let (.some(current), .none): return "HP \(current)"
							case let (.none, .some(maximum)): return "Max HP \(maximum)"
							case (.none, .none): return nil
							}
						}()
						let speed = stats?.speeds.filter { !$0.isEmpty }.map { "\($0.mode.description) \($0.distance.description)" }.joined(separator: ", ")
						let summary = [
							stats?.armorClass.map { "AC \($0)" },
							hp,
							stats?.health.temporaryHitPoints.map { "Temp HP \($0)" },
							speed,
						].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " • ")
						if !summary.isEmpty { JCSText(summary, theme) }
						if let stats {
							let abilityText = stats.abilities.filter { !$0.isEmpty }.map { ability in
								let save = ability.savingThrow.map { " • Save \($0.signedDescription())" } ?? ""
								return "\(ability.ability.abbreviation) \(ability.score.map { String($0) } ?? "?") (\(ability.modifier?.signedDescription() ?? "?"))\(save)"
							}.joined(separator: " • ")
							if !abilityText.isEmpty { JCSText(abilityText, theme) }
							if let hitDice = stats.health.hitDice { JCSText("Hit Dice: " + hitDice.filter { !$0.isEmpty }.map(\.description).joined(separator: ", "), theme) }
							if let remaining = stats.health.remainingHitDice { JCSText("Remaining: " + remaining.filter { !$0.isEmpty }.map(\.description).joined(separator: ", "), theme) }
							if !stats.health.isEmpty { JCSText("Death Saves: \(stats.health.deathSaveSuccesses) success / \(stats.health.deathSaveFailures) failure • Stable: \(stats.health.isStable ? "Yes" : "No")", theme) }
							stats.attacks.filter { !$0.isEmpty }.map { JCSText("Attack: \($0.name) — \($0.sheetResolutionDescription(jargon: jargon)) — \($0.sheetDamageDescription(jargon: jargon)) — \($0.sheetDeliveryDescription(jargon: jargon)) — \($0.sheetDetailDescription(jargon: jargon))", theme, lines: 0...4) }
							stats.features.filter { !$0.isEmpty }.map { feature in
								let counter = feature.counter.map { " — \($0.description)" } ?? ""
								return JCSText("Feature: \(feature.name)\(feature.source.isEmpty ? "" : " — \(feature.source)")\(counter)\(feature.detail.isEmpty ? "" : ": \(feature.detail)")", theme, lines: 0...3)
							}
						}
						let notes = (creature.notes + (stats?.notes ?? [])).filter { !$0.isEmpty }.joined(separator: "; ")
						if !notes.isEmpty { JCSText(notes, theme) }
					}
					rowRender: { theme.rowLineSeperator($0) }
				}
			}
		}
	}
}
