import Foundation
import SBJLayout

@JCSLayoutElementBuilder
func movementAndSenses(_ c: Character, _ theme: any Theme, _ jargon: any Jargon, _ dimension: TrackSize = .fill()) -> JCSLayoutElements {
	let value = c.life.movementAndSenses
	if !value.isEmpty {
		let speedText = value.speeds.filter { !$0.isEmpty }.map {
			"\($0.mode.description): \($0.distance.description)"
		}.joined(separator: ", ")
		let senseText = value.senses.filter { !$0.isEmpty }.map {
			[$0.kind.description, $0.range?.description, $0.detail]
				.compactMap { $0 }
				.filter { !$0.isEmpty }
				.joined(separator: " — ")
		}.joined(separator: "; ")
		modelSection(theme, "Movement & Senses", fields: [
			.init("Movement", speedText),
			.init("Senses", senseText),
			.init("Notes", value.notes.filter { !$0.isEmpty }.joined(separator: "; ")),
		], dimension)
	}
}
