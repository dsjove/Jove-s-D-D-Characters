import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func spellcasting(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	if c.capabilities.spellcasting.hasContent {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, "Spellcasting")
			c.capabilities.spellcasting.filter { !$0.isEmpty }.map { casting in
				Panel(theme) {
					Grid(vertFlow: .init(dimension)) {
						JCSText(casting.source.isEmpty ? "Spellcasting" : casting.source, theme, font: .lineItemBold)
						let castingMetadata = [
							casting.tradition?.description,
							casting.ability.map { "\($0.description)" },
							casting.spellSaveDC.map { "Save DC \($0)" },
							casting.spellAttackBonus.map { "Attack \($0.signedDescription())" },
							casting.focus.map { "Focus: \($0)" },
						].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " • ")
						if !castingMetadata.isEmpty { JCSText(castingMetadata, theme) }
						let slotText = casting.slots.filter { !$0.isEmpty }.map { "\($0.level.description): \($0.counter.description)" }.joined(separator: " • ")
						if !slotText.isEmpty { JCSText(slotText, theme, font: .lineItemBold) }
						casting.spells.filter { !$0.isEmpty }.map { spell in
							let flags = [spell.ritual ? "Ritual" : nil, spell.concentration ? "Concentration" : nil].compactMap { $0 }.joined(separator: ", ")
							let meta = [spell.level.description, spell.school, spell.preparation.description, spell.castingTime, spell.range, spell.components.isEmpty ? nil : spell.components.joined(separator: "/"), spell.duration, flags.isEmpty ? nil : flags, spell.isPrepared.map { $0 ? "Prepared" : "Not prepared" }].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " • ")
							return JCSText("\(spell.name)\(meta.isEmpty ? "" : " — \(meta)")\(spell.detail.isEmpty ? "" : "\n\(spell.detail)")", theme, lines: 0...5)
						}
						let notes = casting.notes.filter { !$0.isEmpty }.joined(separator: "; ")
						if !notes.isEmpty { JCSText(notes, theme) }
					}
				}
			}
		}
	}
}
