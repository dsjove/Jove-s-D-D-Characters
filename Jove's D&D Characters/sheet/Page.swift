import Foundation
import CoreGraphics
import SBJLayout

public protocol Page {
	func isEmpty(_ c: Character) -> Bool

	@JCSLayoutElementBuilder
	func draw(
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon
	) -> JCSLayoutElements
}

public extension Page {
	func draw(
		_ c: Character,
		_ theme: Theme,
		_ jargon: any Jargon,
		_ pagination: Pagination
	) {
		guard !isEmpty(c) else { return }
		let rect = pagination.contentRect
		Grid(
			vertFlow: .init(.fill()),
			rows: .init(gap: theme.sectionGap)
		) {
			draw(c, theme, jargon)
		}.draw(at: rect.origin, bounds: CGSize(fixedWidth: rect.width))
	}
}
