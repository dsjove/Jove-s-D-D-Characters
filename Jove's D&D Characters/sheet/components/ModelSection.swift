import Foundation
import SBJLayout

struct SheetField: EmptyCheckable {
	let label: String
	let value: String

	init(_ label: String, _ value: String?) {
		self.label = label
		self.value = value ?? ""
	}

	var isEmpty: Bool {
		value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}
}

@JCSLayoutElementBuilder
func modelSection(
	_ theme: any Theme,
	_ title: String,
	fields: [SheetField],
	align: Alignment = .leftCenter,
	_ dimension: TrackSize = .fill()
) -> JCSLayoutElements {

	let visible = fields.filter { !$0.isEmpty }
	if !visible.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, title)
			Panel(theme) {
				Grid(
					table: [
						.init(.intrinsic(), align: .leftCenter, gap: 12),
						.init(dimension, align: align)
					]
				) {
					visible.map { field in [
						JCSText(field.label, theme, font: .lineItemBold, color: .titleBackground, lines: 0...2),
						JCSText(field.value, theme),
					] }
				}
				colRender: { theme.colLineSeperator($0) }
				rowRender: { theme.rowLineSeperator($0) }
			}
		}
	}
}

func sheetList(_ values: [String]) -> String {
	values.filter { !$0.isEmpty }.joined(separator: ", ")
}

