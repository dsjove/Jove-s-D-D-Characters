import Foundation
import CoreGraphics
import SBJLayout
import PDFKit

struct Sheet {
	let name: String
	let pages: [PagedContent]

	func render(_ theme: Theme, _ character: Character, _ jargon: any Jargon) -> (Data, PDFDocument?) {
		let generator = PDFGenerator()
		let render = SheetRender(theme, character, jargon, pages)
		let generated = generator.form(render) { page in
			background(theme, page)
		}
		return generated
	}
}

public protocol PagedContent {
	func isEmpty(_ c: Character) -> Bool

	@JCSLayoutElementBuilder
	func layout(
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon
	) -> JCSLayoutElements
}

//TODO: Pagination - this needs become a JCSLayoutElement struct
//TODO: Pagination - init registers id
//TODO: Pagination - have a measure that requests pagination
//TODO: Pagination - have a draw the tells pagination we are rendering
//TODO: Pagination - current draw does the measuring implicitely with Grid draw!
public extension PagedContent {
	func draw(
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon,
		_ pagination: Pagination
	) {
		guard !isEmpty(c) else { return }
		pagination.renderPageInsert(1)
		let rect = theme.pageContentInset.apply(rect: pagination.printableRect)
		Grid(
			vertFlow: .init(.fill()),
			rows: .init(gap: theme.sectionGap)
		) {
			layout(c, theme, jargon)
		}.draw(at: rect.origin, bounds: CGSize(fixedWidth: rect.width))
	}
}
func background(_ theme: Theme, _ page: Pagination){
	theme.pageBackground?.draw(in: page.printableRect)
}

struct SheetRender: JCSLayoutElement {
	let theme: Theme
	let character: Character
	let jargon: any Jargon
	let pages: [PagedContent]
	var paginationId: Int?

	public init(_ theme: Theme, _ character: Character, _ jargon: any Jargon, _ pages: [PagedContent]) {
		self.theme = theme
		self.character = character
		self.jargon = jargon
		self.pages = pages
		self.paginationId = pagination.registerGroup()
	}

	public func measure(bounds: CGSize) -> CGSize {
		pagination.beginMeasureGroup(paginationId)
//TODO: Pagination - actually perform the measure
		let size = bounds
		pagination.endMeasureGroup(paginationId, size)
		return size
	}

	public func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		pagination.rendering(paginationId)
		for content in pages where !content.isEmpty(character) {
//TODO: Pagination - have each page renderPageInsert in measure
			content.draw(character, theme, jargon, pagination)
		}
	}
}
