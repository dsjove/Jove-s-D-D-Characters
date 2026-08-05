import UIKit
import SBJLayout

struct SectionTitle: JCSLayoutElement, EmptyCheckable {
	let panel: JCSRect?
	let panelInsetH: CGFloat
	let panelInsetV: CGFloat
	let textItem: JCSText
	let isEmpty: Bool

	init(_ theme: Theme, _ title: String) {
		isEmpty = title.isEmpty
		panel = theme.sectionTitlePanel
		panelInsetH = theme.sectionTitleHorizontalPadding
		panelInsetV = theme.sectionTitleVerticalPadding
		textItem = JCSText(title, font: theme.sectionTitleFont, color: theme.sectionTitleColor, lines: 1)
	}

	func measure(bounds: CGSize) -> CGSize {
		isEmpty ? .zero : textItem.measure(bounds: bounds).inset(dx: -panelInsetH, dy: -panelInsetV)
	}

	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		guard !isEmpty else { return }
		panel?.draw(in: allocated)
		let contentRect = allocated.insetBy(dx: panelInsetH, dy: panelInsetV)
		textItem.draw(in: contentRect, measured: measured, align: align)
	}
}
