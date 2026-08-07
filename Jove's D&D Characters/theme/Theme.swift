import UIKit
import SBJLayout

public enum ThemeFont {
	case pageTitle
	case pageSubtitle
	case sectionTitle
	case body
	case lineItem
	case lineItemBold
}

public enum ThemeColor {
	case pageTitle
	case pageSubtitle
	case sectionTitle
	case ink
	case titleBackground
	case gridLine
}

public extension JCSText {
	init(
		_ text: StringPresentable?,
		_ theme: Theme,
		font: ThemeFont = .body,
		color: ThemeColor = .ink,
		align: Alignment? = nil,
		lines: ClosedRange<Int>? = nil
	) {
		self.init(
			text?.description,
			theme,
			font: font,
			color: color,
			align: align,
			lines: lines)
	}
}

public extension JCSText {
	init(
		_ text: String?,
		_ theme: Theme,
		font: ThemeFont = .body,
		color: ThemeColor = .ink,
		align: Alignment? = nil,
		lines: ClosedRange<Int>? = nil
	) {
		self.init(
			text?.description,
			font: theme.font(font),
			color: theme.color(color),
			align: align,
			lines: lines)
	}
}

public protocol Theme: Sendable {
	var name: String { get }

	func font(_ font: ThemeFont) -> UIFont
	func color(_ color: ThemeColor) -> UIColor

	var pageBackground: JCSRect? { get }
	var pageContentInset: Insets { get }

	var pageHeaderPanel: JCSRect? { get }
	var pageHeaderInsets: Insets { get }

	var sectionTitlePanel: JCSRect? { get }
	var sectionTitleInsets: Insets { get }

	var sectionTitleGap: CGFloat { get }
	var sectionGap: CGFloat { get }

	var contentPanel: JCSRect? { get }
	var contentPanelInset: CGFloat { get }

	func colLineSeperator(_ col: Grid.ColumnIteration)
	func rowLineSeperator(_ row: Grid.RowIteration)
}
