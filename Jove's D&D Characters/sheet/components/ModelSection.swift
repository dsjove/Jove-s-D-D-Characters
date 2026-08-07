import Foundation
import SBJLayout

struct SheetField: EmptyCheckable {
	let label: String
	let value: String

	init(_ label: String, _ value: String?) {
		self.label = label
		self.value = value ?? ""
	}

	var isEmpty: Bool { value.isEmpty }
}

@JCSLayoutElementBuilder
func modelSection(
	_ theme: any Theme,
	_ title: String,
	fields: [SheetField],
	_ dimension: TrackSize = .fill()
) -> JCSLayoutElements {
	let visible = fields.filter { !$0.isEmpty }
	if !visible.isEmpty {
		Grid(vertFlow: .init(dimension), rows: .init(gap: theme.sectionTitleGap)) {
			SectionTitle(theme, title)
			Panel(theme) {
				Grid(
					table: [.init(.intrinsic(), gap: 16), .init(dimension)],
					rows: .init(align: .leftCenter)
				) {
					visible.map { field in [
						JCSText(field.label, theme, font: .lineItemBold, color: .titleBackground, lines: 0...2),
						JCSText(field.value, theme, font: .body, color: .ink),
					] }
				}
				rowRender: { theme.rowLineSeperator($0) }
				colRender: { theme.colLineSeperator($0) }
			}
		}
	}
}

func sheetList(_ values: [String]) -> String {
	values.filter { !$0.isEmpty }.joined(separator: ", ")
}

