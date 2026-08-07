import UIKit
import SBJLayout

//TODO: use Panel from SBJLayout
struct Panel: JCSLayoutElement {
	let panel: JCSRect?
	let panelInset: CGFloat
	let aspectRatio: Bool
	let content: JCSLayoutElements

	init(
		_ theme: Theme,
		aspectRatio: Bool = false,
		_ content: JCSLayoutElements
		) {
		self.panel = theme.contentPanel
		self.panelInset = theme.contentPanelInset
		self.aspectRatio = aspectRatio
		self.content = content
	}

	init(
		_ theme: Theme,
		aspectRatio: Bool = false,
		@JCSLayoutElementBuilder content: () -> JCSLayoutElements) {
		self.init(theme, aspectRatio: aspectRatio, content())
	}

	func measure(bounds: CGSize) -> CGSize {
		let inset = bounds.inset(dx: panelInset, dy: panelInset)
		let size = content.first?.measure(bounds: inset) ?? .zero
		var outset = size.inset(dx: -panelInset, dy: -panelInset)
//		if aspectRatio {
//			let dim = max(outset.width, outset.height)
//			outset.width = dim
//			outset.height = dim
//		}
		return outset
	}
	
	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		panel?.draw(in: allocated)
		let contentRect = allocated.insetBy(dx: panelInset, dy: panelInset)
		for subview in content {
			subview.draw(in: contentRect, measured: contentRect.size, align: align)
		}
	}
}
