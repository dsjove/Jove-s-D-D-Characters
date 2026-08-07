import UIKit
import SBJLayout

struct PageTitle: JCSLayoutElement {
	let isEmpty: Bool
	let panel: SBJLayout.Panel<Grid>

	init(_ theme: Theme, _ title: String, _ subtitle: String? = nil) {
		isEmpty = title.isEmpty && subtitle?.isEmpty ?? true
		self.panel = SBJLayout.Panel(
			insets: theme.pageHeaderInsets,
			align: .center,
			background: theme.pageHeaderPanel!
		) {
			Grid(vertFlow: .init(.fill())) {
				JCSText(title, font: theme.largeAttributeFont, color: theme.pageHeaderTextColor)
				JCSText(subtitle, font: theme.pageHeaderSubtitleFont, color: theme.pageHeaderTextColor)
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
