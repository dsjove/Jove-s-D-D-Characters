import Foundation
import SBJLayout
import UIKit

public extension JCSText {
	init(_
		text: StringPresentable?,
		font: UIFont? = nil,
		color: UIColor? = nil,
		align: Alignment? = nil,
		lines: ClosedRange<Int>? = nil
	) {
		self.init(
			text?.description,
			font: font,
			color: color,
			align: align,
			lines: lines)
	}
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

public extension SBJLayout.Panel {
	init(
		_ theme: Theme,
		@JCSLayoutElementOptionalBuilder
		content: ()->C?
	) {
		self.init(
			insets: theme.contentPanelInset,
			background: theme.contentPanel!,
			content: content)
	}
}
