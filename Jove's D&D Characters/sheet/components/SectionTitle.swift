import UIKit
import SBJLayout

struct SectionTitle: JCSLayoutElement, EmptyCheckable {
	let isEmpty: Bool
	let panel: SBJLayout.Panel<JCSText>

	init(_ theme: Theme, _ title: String) {
		isEmpty = title.isEmpty
		self.panel = SBJLayout.Panel(
			insets: theme.sectionTitleInsets,
			background: theme.pageHeaderPanel!
		) {
			JCSText(title, theme, font: .sectionTitle, color: .sectionTitle, lines: 1...1)
		}
	}

	func measure(bounds: CGSize) -> CGSize {
		guard !isEmpty else { return .zero }
		return panel.measure(bounds: bounds)
	}

	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		guard !isEmpty else { return }
		panel.draw(in: allocated, measured: measured, align: align)
	}
}
