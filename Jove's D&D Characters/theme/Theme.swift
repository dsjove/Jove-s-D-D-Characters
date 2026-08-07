import UIKit
import SBJLayout

public enum ThemeFont {
	case pageTitle
	case pageSubtitle
	case sectionTitle
	case body
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
		lines: ClosedRange<Int> = 0...Int.max
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
		lines: ClosedRange<Int> = 0...Int.max
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

//TODO: Normalize
public extension Theme {
	static func font(ofSize size: CGFloat = 12, bold: Bool = false) -> UIFont {
		bold ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
	}

	var largeAttributeFont: UIFont { Self.font(ofSize: 22, bold: true) }
	var smallNoteFont: UIFont { Self.font(ofSize: 9, bold: false) }
	var smallNoteBoldFont: UIFont { Self.font(ofSize: 9, bold: true) }

	var skillNameFont: UIFont { Self.font(ofSize: 11.5, bold: false) }
	var skillNameBoldFont: UIFont { Self.font(ofSize: 11.5, bold: true) }
	var skillMarkFont: UIFont { Self.font(ofSize: 10, bold: true) }
	var featureHeadingFont: UIFont { Self.font(ofSize: 11.5, bold: true) }
	var featureBodyFont: UIFont { Self.font(ofSize: 9.7, bold: false) }
	var proficiencyLineFont: UIFont { Self.font(ofSize: 11, bold: true) }
	var maneuverNameFont: UIFont { Self.font(ofSize: 10.5, bold: true) }
	var maneuverBodyFont: UIFont { Self.font(ofSize: 8.2, bold: false) }
}
