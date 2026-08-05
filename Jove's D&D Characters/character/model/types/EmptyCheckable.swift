import Foundation

/// A model value that can determine whether it contains meaningful sheet data.
public protocol EmptyCheckable {
	var isEmpty: Bool { get }
}

public extension EmptyCheckable {
	var hasContent: Bool { !isEmpty }
}

/// Collections of model values are effectively empty when they contain no
/// non-empty values. This differs from `Collection.isEmpty`, which only tests
/// the number of elements.
public extension Sequence where Element: EmptyCheckable {
	var isEffectivelyEmpty: Bool { allSatisfy(\.isEmpty) }
	var hasContent: Bool { contains { !$0.isEmpty } }
}

public extension Optional {
	var isEmpty: Bool { self == nil }
	var hasContent: Bool { self != nil }
}

public extension Optional where Wrapped: EmptyCheckable {
	var isEmpty: Bool {
		switch self {
		case .none: true
		case .some(let wrapped): wrapped.isEmpty
		}
	}

	var hasContent: Bool { !isEmpty }
}
