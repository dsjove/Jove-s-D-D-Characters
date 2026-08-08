import Foundation

public struct Feature: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P/G ! — rules feature or custom content
	public let source: String // H+P/G ~ — rules feature or custom content
	public let counter: ResourceCounter?
	public let detail: String // H+P/G ~ — rules feature or custom content

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

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		try validate(counter, at: \Self.counter)
	}
}
