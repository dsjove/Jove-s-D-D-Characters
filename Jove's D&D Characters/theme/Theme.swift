import UIKit
import SBJLayout

public enum ThemeFont {
	case pageTitle
	case pageSubtitle
	case sectionTitle
	case body
	case smallBody
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
	var contentPanelInset: Insets { get }

	func colLineSeperator(_ col: Grid.ColumnIteration, _ every: Int?)
	func rowLineSeperator(_ row: Grid.RowIteration, _ every: Int?)
}

extension Theme {
	func colLineSeperator(_ col: Grid.ColumnIteration) {
		colLineSeperator(col, nil)
	}
	func rowLineSeperator(_ row: Grid.RowIteration) {
		rowLineSeperator(row, nil)
	}
}
