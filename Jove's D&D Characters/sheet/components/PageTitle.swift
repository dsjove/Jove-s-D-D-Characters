import UIKit
import SBJLayout

struct PageTitle: JCSLayoutElement {
	let isEmpty: Bool
	let panel: OldPanel

	init(_ theme: Theme, _ title: String, _ subtitle: String? = nil) {
		isEmpty = title.isEmpty && subtitle?.isEmpty ?? true
		self.panel = OldPanel(theme.pageHeaderPanel, theme.pageHeaderInsets) {
			Grid(vertFlow: .init(.fill())) {
				JCSText(title, theme, font: .pageTitle, color: .pageTitle)
				JCSText(subtitle, theme, font: .pageSubtitle, color: .pageSubtitle)
			}
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
