import Foundation
import CoreGraphics
import SBJLayout

public struct SheetRender: JCSLayoutElement {
	let theme: Theme
	let character: Character
	let jargon: any Jargon
	let pages: [Page]

	public func measure(bounds: CGSize) -> CGSize {
		bounds
	}

	public func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		for content in pages where !content.isEmpty(character) {
			page.beginPage()
			content.draw(character, theme, jargon, page)
		}
	}

	static func background(_ theme: Theme, _ page: Pagination) -> CGRect {
		theme.pageBackground?.draw(in: page.printableRect)
		let inset = theme.pageContentInset
		return inset.apply(rect: page.printableRect)
	}
}
