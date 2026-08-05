import Foundation

public struct Feature: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let source: String
	public let counter: ResourceCounter?
	public let detail: String

	public init(
		_ name: String = .init(),
		source: String = "",
		counter: ResourceCounter? = nil,
		detail: String = "",
	) {
		self.name = name
		self.source = source
		self.counter = counter
		self.detail = detail
	}

	public var isEmpty: Bool {
		name.isEmpty && source.isEmpty && counter.isEmpty && detail.isEmpty
	}
}
