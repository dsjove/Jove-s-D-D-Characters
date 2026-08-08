import Foundation
import CoreGraphics
import SBJLayout
import PDFKit

struct Sheet {
	let name: String
	let content: [SheetGroupContent]

	func render(_ theme: Theme, _ character: Character, _ jargon: any Jargon) -> (Data, PDFDocument?) {
		let generator = PDFGenerator()
		let render = SheetRender(theme, character, jargon, content)
		let generated = generator.form(render) { page in
			background(theme, page)
		}
		return generated
	}
}

protocol SheetGroupContent {
	func isEmpty(_ c: Character) -> Bool

	@JCSLayoutElementBuilder
	func layout(
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon
	) -> JCSLayoutElements
}

//TODO: PagedElement needs to become conceptual groupings
struct SheetContentGroup: JCSLayoutElement  {
	let isEmpty: Bool
	let grid: Grid
	let pageInsets: Insets
	var paginationId: Int?

	init(
		_ content: SheetGroupContent,
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon
	) {
		let isEmpty = content.isEmpty(c)
		self.isEmpty = isEmpty
		self.pageInsets = theme.pageContentInset
		self.grid = Grid(
			vertFlow: .init(.fill()),
			rows: .init(gap: theme.sectionGap)
		) {
			content.layout(c, theme, jargon)
		}
		self.paginationId = pagination.registerGroup()
	}

	func measure(bounds: CGSize) -> CGSize {
		guard !isEmpty else { return .zero }
		pagination.beginMeasureGroup(paginationId)
//TODO: this hard request needs to go away
		pagination.requestPageInsert(paginationId)
		let inset = pageInsets.apply(size: bounds)
		let size = self.grid.measure(bounds: inset)
		let outset = pageInsets.apply(size: size, inverse: true)
		pagination.endMeasureGroup(paginationId, outset)
		return outset
	}

	func draw(in allocated: CGRect, measured: CGSize, align: SBJLayout.Alignment) {
		guard !isEmpty else { return }
		pagination.rendering(paginationId)
		var positioned = pageInsets.apply(rect: allocated)
		let contentMeasured = pageInsets.apply(size: measured)
//TODO: origin needs to be provided by pagination for groups
		positioned.origin.x = pagination.printableRect.origin.x + pageInsets.left
		positioned.origin.y = pagination.printableRect.minY + pageInsets.top
		self.grid.draw(in: positioned, measured: contentMeasured, align: align)
	}
}
func background(_ theme: Theme, _ page: Pagination){
	theme.pageBackground?.draw(in: page.printableRect)
}

struct SheetRender: JCSLayoutElement {
	let grid: Grid

	init(_ theme: Theme, _ character: Character, _ jargon: any Jargon, _ pages: [SheetGroupContent]) {
		self.grid = Grid(
			vertFlow: .init(.fill()),
			rows: .init(gap: theme.sectionGap)
		) {
			pages.map {
				SheetContentGroup($0, character, theme, jargon)
			}
		}
	}

	func measure(bounds: CGSize) -> CGSize {
		return self.grid.measure(bounds: bounds)
	}

	func draw(in allocated: CGRect, measured: CGSize, align: Alignment) {
		self.grid.draw(in: allocated, measured: measured, align: align)
	}
}
