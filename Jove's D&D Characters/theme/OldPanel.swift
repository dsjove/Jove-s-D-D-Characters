import UIKit
import SBJLayout

//TODO: use Panel from SBJLayout
struct OldPanel: JCSLayoutElement {
	let panel: JCSRect?
	let panelInsetX: CGFloat
	let panelInsetY: CGFloat
	let content: JCSLayoutElements

	init(
		_ panel: JCSRect?,
		_ panelInset: Insets,
		@JCSLayoutElementBuilder
		content: () -> JCSLayoutElements
	) {
		self.panel = panel
		self.panelInsetX = panelInset.left
		self.panelInsetY = panelInset.top
		self.content = content()
	}

	init(
		_ theme: Theme,
		_ content: JCSLayoutElements
	) {
		self.panel = theme.contentPanel
		self.panelInsetX = theme.contentPanelInset.left
		self.panelInsetY = theme.contentPanelInset.top
		self.content = content
	}

	init(
		_ theme: Theme,
		@JCSLayoutElementBuilder
		content: () -> JCSLayoutElements
	) {
		self.init(theme, content())
	}

	func measure(bounds: CGSize) -> CGSize {
		let inset = bounds.inset(dx: panelInsetX, dy: panelInsetY)
		let size = content.first?.measure(bounds: inset) ?? .zero
		let outset = size.inset(dx: -panelInsetX, dy: -panelInsetY)
		return outset
	}
	
	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		panel?.draw(in: allocated)
		let contentRect = allocated.insetBy(dx: panelInsetX, dy: panelInsetY)
		for subview in content {
			subview.draw(in: contentRect, measured: contentRect.size, align: align)
		}
	}
}
