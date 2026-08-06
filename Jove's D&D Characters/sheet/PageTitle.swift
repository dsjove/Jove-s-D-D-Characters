import UIKit
import SBJLayout

struct PageTitle: JCSLayoutElement {
	let panel: JCSRect?
	let panelInsetH: CGFloat
	let panelInsetV: CGFloat
	let grid: any JCSLayoutElement
	let isEmpty: Bool

	init(_ theme: Theme, _ title: String, _ subtitle: String? = nil) {
		isEmpty = title.isEmpty && subtitle?.isEmpty ?? true
		panel = theme.pageHeaderPanel
		panelInsetH = theme.pageHeaderInset.width
		panelInsetV = theme.pageHeaderInset.height
		grid = Grid(vertFlow: .init(.fill())) {
			JCSText(title, font: theme.largeAttributeFont, color: theme.pageHeaderTextColor)
			JCSText(subtitle, font: theme.pageHeaderSubtitleFont, color: theme.pageHeaderTextColor)
		}
	}

	func measure(bounds: CGSize) -> CGSize {
		guard !isEmpty else { return .zero }
		let inset = bounds.inset(dx: panelInsetH, dy: panelInsetV)
		let size = grid.measure(bounds: inset)
		let outset = size.inset(dx: -panelInsetH, dy: -panelInsetV)
		return outset
	}

	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		guard !isEmpty else { return }
		panel?.draw(in: allocated)
		let contentRect = allocated.insetBy(dx: panelInsetH, dy: panelInsetV)
		grid.draw(in: contentRect, measured: contentRect.size, align: align)
	}
}

struct PageTitle2: JCSLayoutElement {
	let isEmpty: Bool
	let grid: any JCSLayoutElement

	init(_ theme: Theme, _ title: String, _ subtitle: String? = nil) {
		isEmpty = title.isEmpty && subtitle?.isEmpty ?? true
		grid = SBJLayout.Panel(
				insets: .init(
					left: theme.pageHeaderInset.width,
					right: theme.pageHeaderInset.width,
					top: theme.pageHeaderInset.height,
					bottom: theme.pageHeaderInset.height),
				align: .center,
				background: theme.pageHeaderPanel!) {
			Grid(vertFlow: .init(.fill())) {
				JCSText(title, font: theme.largeAttributeFont, color: theme.pageHeaderTextColor)
				JCSText(subtitle, font: theme.pageHeaderSubtitleFont, color: theme.pageHeaderTextColor)
			}
		}
	}

	func measure(bounds: CGSize) -> CGSize {
		guard !isEmpty else { return .zero }
		return grid.measure(bounds: bounds)
	}

	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		guard !isEmpty else { return }
		grid.draw(in: allocated, measured: measured, align: align)
	}
}

