import Foundation

public struct InvariantPath: Equatable, @unchecked Sendable, CustomStringConvertible {
	private enum Component: Equatable {
		case property(AnyKeyPath)
		case index(Int)
	}

	private var components: [Component]

	public init<Root, Value>(_ keyPath: KeyPath<Root, Value>) {
		components = [.property(keyPath)]
	}

	private init(components: [Component]) {
		self.components = components
	}

	public func appending<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> Self {
		.init(components: components + [.property(keyPath)])
	}

	public func appending(index: Int) -> Self {
		.init(components: components + [.index(index)])
	}

	public func prepending(_ prefix: Self) -> Self {
		.init(components: prefix.components + components)
	}

	public var description: String {
		var result = ""
		for component in components {
			switch component {
			case .property(let keyPath):
				let rendered = Self.render(keyPath)
				if !result.isEmpty && !rendered.isEmpty { result += "." }
				result += rendered
			case .index(let index):
				result += "[\(index)]"
			}
		}
		return result
	}

	private static func render(_ keyPath: AnyKeyPath) -> String {
		let rendered = String(describing: keyPath)
		guard let dot = rendered.firstIndex(of: ".") else { return rendered }
		return String(rendered[rendered.index(after: dot)...])
	}
}

public struct InvariantViolation: Error, Equatable, Sendable, CustomStringConvertible {
	public let path: InvariantPath
	public let requirement: String

	public init(_ path: InvariantPath, _ requirement: String) {
		self.path = path
		self.requirement = requirement
	}

	public var description: String {
		"\(path): \(requirement)"
	}
}

public protocol InvariantCheckable {
	func invariant() throws
}

func require(
	_ condition: @autoclosure () -> Bool,
	_ path: InvariantPath,
	_ requirement: String
) throws {
	guard condition() else { throw InvariantViolation(path, requirement) }
}

func require<Root, Value>(
	_ condition: @autoclosure () -> Bool,
	_ path: KeyPath<Root, Value>,
	_ requirement: String
) throws {
	try require(condition(), InvariantPath(path), requirement)
}

func requireMeaningful<Root, Value>(_ value: String, _ path: KeyPath<Root, Value>) throws {
	try require(
		!value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
		path,
		"must contain non-whitespace text"
	)
}

func validate<T: InvariantCheckable>(_ value: T, at path: InvariantPath) throws {
	do { try value.invariant() }
	catch let violation as InvariantViolation {
		throw InvariantViolation(violation.path.prepending(path), violation.requirement)
	}
}

func validate<Root, Value, T: InvariantCheckable>(
	_ value: T,
	at path: KeyPath<Root, Value>
) throws {
	try validate(value, at: InvariantPath(path))
}

func validate<T: InvariantCheckable>(_ values: [T], at path: InvariantPath) throws {
	for (index, value) in values.enumerated() {
		try validate(value, at: path.appending(index: index))
	}
}

func validate<Root, Value, T: InvariantCheckable>(
	_ values: [T],
	at path: KeyPath<Root, Value>
) throws {
	try validate(values, at: InvariantPath(path))
}

func validate<T: InvariantCheckable>(_ value: T?, at path: InvariantPath) throws {
	if let value { try validate(value, at: path) }
}

func validate<Root, Value, T: InvariantCheckable>(
	_ value: T?,
	at path: KeyPath<Root, Value>
) throws {
	try validate(value, at: InvariantPath(path))
}

func validate<T: InvariantCheckable>(_ values: [T]?, at path: InvariantPath) throws {
	if let values { try validate(values, at: path) }
}

func validate<Root, Value, T: InvariantCheckable>(
	_ values: [T]?,
	at path: KeyPath<Root, Value>
) throws {
	try validate(values, at: InvariantPath(path))
}

func requireUnique<Root, Value, T: Hashable>(
	_ values: [T],
	_ path: KeyPath<Root, Value>,
	_ requirement: String
) throws {
	try require(Set(values).count == values.count, path, requirement)
}
