import UIKit
import SBJLayout

public protocol Theme: Sendable {
	var name: String { get }

	var pageBackground: JCSRect? { get }
	var pageContentInset: CGSize { get }

	var pageHeaderPanel: JCSRect? { get }
	var pageHeaderFont: UIFont { get }
	var pageHeaderTextColor: UIColor { get }
	var pageHeaderSubtitleFont: UIFont { get }
	var pageHeaderInset: CGSize { get }

	var sectionTitlePanel: JCSRect? { get }
	var sectionTitleFont: UIFont { get }
	var sectionTitleColor: UIColor { get }
	var sectionTitleHorizontalPadding: CGFloat { get }
	var sectionTitleVerticalPadding: CGFloat { get }
	var sectionTitleGap: CGFloat { get }
	var sectionGap: CGFloat { get }

	var panel: JCSRect { get }
	var panelInset: CGFloat { get }

	var columnGap: CGFloat { get }
	var rowGap: CGFloat { get }
	func lineSeperator(_ row: Grid.RowIteration)

	var largeAttributeFont: UIFont { get }
	var smallNoteFont: UIFont { get }
	var smallNoteBoldFont: UIFont { get }

	var accentColor: UIColor { get }
	var ink: UIColor { get }

//TODO: normalize
	var skillNameFont: UIFont { get }
	var skillNameBoldFont: UIFont { get }
	var skillMarkFont: UIFont { get }
	var featureHeadingFont: UIFont { get }
	var featureBodyFont: UIFont { get }
	var proficiencyLineFont: UIFont { get }
	var maneuverNameFont: UIFont { get }
	var maneuverBodyFont: UIFont { get }
}

public extension Theme {
	func font(ofSize size: CGFloat = 12, bold: Bool = false) -> UIFont {
		bold ? UIFont.boldSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size)
	}

	var pageBackground: JCSRect? {
		JCSRect(
			fill: .init(red: 0xFC/255, green: 0xF8/255, blue: 0xF1/255, alpha: 1),
			stroke: .init(red: 0x9A/255, green: 0x64/255, blue: 0, alpha: 1),
			lineWidth: 2,
			radius: 0)
	}
	var pageContentInset: CGSize { .init(width: 18.0, height: 18.0) }

	var pageHeaderPanel: JCSRect? {
		JCSRect(
			fill: accentColor,
			stroke: .clear,
			lineWidth: 0,
			radius: 6)
	}
	var pageHeaderFont: UIFont { font(ofSize: 22, bold: true) }
	var pageHeaderTextColor: UIColor { .white }
	var pageHeaderSubtitleFont: UIFont { font(ofSize: 11, bold: false) }
	var pageHeaderInset: CGSize { .init(width: 15, height: 7) }

	var sectionTitlePanel: JCSRect? {
		JCSRect(
			fill: accentColor,
			stroke: .clear,
			lineWidth: 0,
			radius: 6)
	}
	var sectionTitleFont: UIFont { font(ofSize: 14, bold: true) }
	var sectionTitleColor: UIColor { .white }
	var sectionTitleHorizontalPadding: CGFloat { 8 }
	var sectionTitleVerticalPadding: CGFloat { 3 }
	var sectionTitleGap: CGFloat { 5 }
	var sectionGap: CGFloat { 9 }

	var panel: JCSRect {
		JCSRect(
			fill: .white,
			stroke: accentColor,
			lineWidth: 1.5,
			radius: 8)
	}
	var  panelInset: CGFloat { 6 }

	var  columnGap: CGFloat { 4 }
	var  rowGap: CGFloat { 4 }
	func lineSeperator(_ row: Grid.RowIteration) {
		if row.index == row.definition.rows.tracks.count-1 { return }
		let r = row.rect
		let gap = row.track.gap / 2.0
		let s = CGPoint(x: r.minX, y: r.maxY + gap)
		let e = CGPoint(x: r.maxX, y: r.maxY + gap)
		JCSLine(stroke: UIColor(red: 0xED/255, green: 0xE1/255, blue: 0xCF/255, alpha: 1), lineWidth: 0.5).draw(from: s, to: e)
	}

	var largeAttributeFont: UIFont { font(ofSize: 22, bold: true) }
	var smallNoteFont: UIFont { font(ofSize: 9, bold: false) }
	var smallNoteBoldFont: UIFont { font(ofSize: 9, bold: true) }

	var accentColor: UIColor { UIColor(red: 0x6B/255, green: 0x2D/255, blue: 0x2D/255, alpha: 1) }
	var ink: UIColor { UIColor(red: 0x21/255, green: 0x1A/255, blue: 0x17/255, alpha: 1) }

	var skillNameFont: UIFont { font(ofSize: 11.5, bold: false) }
	var skillNameBoldFont: UIFont { font(ofSize: 11.5, bold: true) }
	var skillMarkFont: UIFont { font(ofSize: 10, bold: true) }
	var featureHeadingFont: UIFont { font(ofSize: 11.5, bold: true) }
	var featureBodyFont: UIFont { font(ofSize: 9.7, bold: false) }
	var proficiencyLineFont: UIFont { font(ofSize: 11, bold: true) }
	var maneuverNameFont: UIFont { font(ofSize: 10.5, bold: true) }
	var maneuverBodyFont: UIFont { font(ofSize: 8.2, bold: false) }
}
