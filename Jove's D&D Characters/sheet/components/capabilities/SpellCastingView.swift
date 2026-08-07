import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func spellcasting(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.capabilities.spellcasting.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, "Spellcasting")
			c.capabilities.spellcasting.map { casting in
				Panel(theme) {
					Grid(vertFlow: .init(dimension)) {
						JCSText(casting.source.isEmpty ? "Spellcasting" : casting.source, theme, font: .lineItemBold)
						JCSText([
							casting.tradition?.description,
							casting.ability.map { "\($0.description)" },
							casting.spellSaveDC.map { "Save DC \($0)" },
							casting.spellAttackBonus.map { "Attack \($0.signedDescription())" },
							casting.focus.map { "Focus: \($0)" },
						].compactMap { $0 }.joined(separator: " • "), theme)
						JCSText(casting.slots.filter { !$0.isEmpty }.map { "\($0.level.description): \($0.counter.description)" }.joined(separator: " • "), theme, font: .lineItemBold)
						casting.spells.filter { !$0.isEmpty }.map { spell in
							JCSText("\(spell.isPrepared == true ? "● " : "")\(spell.name) — \(spell.level.description)\(spell.detail.isEmpty ? "" : ": \(spell.detail)")", theme, lines: 0...3)
						}
						JCSText(casting.notes.joined(separator: "; "), theme)
					}
				}
			}
		}
	}
}
