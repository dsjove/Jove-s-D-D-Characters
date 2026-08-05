import Foundation

public struct DetailedSection: Codable, Sendable, EmptyCheckable {
	let name: String
	let sections: [TitledBody]

	public init(_ name: String = "", _ sections: [TitledBody] = []) {
		self.name = name
		self.sections = sections
	}

	public init(_ name: String = "", _ sections: [String]) {
		self.name = name
		self.sections = sections.map { .init($0) }
	}

	public init<T: StringPresentable>(_ name: T, _ sections: [TitledBody] = []) {
		self.name = name.description
		self.sections = sections
	}

	public init<T: StringPresentable>(_ name: T, _ sections: [String]) {
		self.name = name.description
		self.sections = sections.map { .init($0) }
	}

	public var isEmpty: Bool {
		name.isEmpty && sections.isEffectivelyEmpty
	}
}

public struct TitledBody: Codable, Sendable, EmptyCheckable {
	public let title: String
	public let body: String

	public init(_ key: String = "", _ body: String = "") {
		self.title = key
		self.body = body
	}

	public var isEmpty: Bool {
		title.isEmpty && body.isEmpty
	}
}
