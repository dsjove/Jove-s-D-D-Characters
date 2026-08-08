import UIKit
import SBJLayout

public class BasicTheme: Theme {
	public let name: String
	public let pageTitleFont: UIFont
	public let pageSubtitleFont: UIFont
	public let sectionTitleFont: UIFont
	public let bodyFont: UIFont
	public let smallBodyFont: UIFont
	public let lineItem: UIFont
	public let lineItemBold: UIFont

	public init(name: String = "Basic") {
		self.name = name
		self.pageTitleFont = UIFont.boldSystemFont(ofSize: 22)
		self.pageSubtitleFont = UIFont.systemFont(ofSize: 11)
		self.sectionTitleFont = UIFont.boldSystemFont(ofSize: 14)
		self.bodyFont = UIFont.systemFont(ofSize: 9)
		self.smallBodyFont = UIFont.systemFont(ofSize: 7)
		self.lineItemBold = UIFont.boldSystemFont(ofSize: 9)
		self.lineItem = UIFont.systemFont(ofSize: 9)
	}

	public func font(_ font: ThemeFont) -> UIFont {
		switch font {
		case .pageTitle: pageTitleFont
		case .pageSubtitle: pageSubtitleFont
		case .sectionTitle: sectionTitleFont
		case .body: bodyFont
		case .smallBody: smallBodyFont
		case .lineItem: lineItem
		case .lineItemBold: lineItemBold
		}
	}

	public func color(_ color: ThemeColor) -> UIColor {
		switch color {
		case .ink: .black
		case .pageTitle: .white
		case .pageSubtitle: .white
		case .sectionTitle: .white
		case .titleBackground: UIColor(red: 0x6B/255, green: 0x2D/255, blue: 0x2D/255, alpha: 1)
		case .gridLine: UIColor(red: 0xED/255, green: 0xE1/255, blue: 0xCF/255, alpha: 1)
		}
	}

	public var pageBackground: JCSRect? {
		JCSRect(
			fill: .init(red: 0xFC/255, green: 0xF8/255, blue: 0xF1/255, alpha: 1),
			stroke: .init(red: 0x9A/255, green: 0x64/255, blue: 0, alpha: 1),
			lineWidth: 2,
			radius: 0)
	}
	public var pageContentInset: Insets {
		.init(dx: 18.0, dy: 18.0)
	}

	public var pageHeaderPanel: JCSRect? {
		JCSRect(
			fill: color(.titleBackground),
			stroke: .clear,
			lineWidth: 0,
			radius: 6)
	}
	public var pageHeaderInsets: Insets { .init(dx: 15, dy: 7) }
	
	public var sectionTitlePanel: JCSRect? {
		JCSRect(
			fill: color(.titleBackground),
			stroke: .clear,
			lineWidth: 0,
			radius: 6)
	}
	public var sectionTitleInsets: Insets { .init(dx: 8, dy: 3) }

	public var sectionTitleGap: CGFloat { 5 }
	public var sectionGap: CGFloat { 9 }

	public var contentPanel: JCSRect? {
		JCSRect(
			fill: .white,
			stroke: color(.titleBackground),
			lineWidth: 1.5,
			radius: 8)
	}
	public var contentPanelInset: Insets { .init(left: 6, right: 6, top: 6, bottom: 6) }

	public func rowLineSeperator(_ row: Grid.RowIteration, _ every: Int? = nil) {
		if row.index == row.definition.rows.tracks.count-1 { return }
		if let every, !(row.index+1).isMultiple(of: every) { return }
		let r = row.rect
		let gap = (row.track.gap / 2.0) + 0.5
		let s = CGPoint(x: r.minX, y: r.maxY + gap)
		let e = CGPoint(x: r.maxX, y: r.maxY + gap)
		JCSLine(stroke: color(.gridLine), lineWidth: 0.5).draw(from: s, to: e)
	}

	public func colLineSeperator(_ col: Grid.ColumnIteration, _ every: Int? = nil) {
		if col.index == col.definition.columns.tracks.count-1 { return }
		if let every, !(col.index+1).isMultiple(of: every) { return }
		let r = col.rect
		let gap = col.track.gap / 2.0
		let s = CGPoint(x: r.maxX + gap, y: r.minY)
		let e = CGPoint(x: r.maxX + gap, y: r.maxY)
		JCSLine(stroke: color(.gridLine), lineWidth: 0.5).draw(from: s, to: e)
	}
}
