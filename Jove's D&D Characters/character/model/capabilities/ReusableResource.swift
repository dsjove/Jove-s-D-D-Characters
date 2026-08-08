import Foundation

public struct ReusableResource: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let name: String // H+P/G ! — rules/custom resource description
	public let counter: ResourceCounter
	public let notes: [String] // H+P/G ~ — rules/custom resource description

	public init(_ name: String = "", counter: ResourceCounter = .init(), notes: [String] = []) {
		self.name = name
		self.counter = counter
		self.notes = notes
	}

	public var isEmpty: Bool { name.isEmpty && counter.isEmpty && notes.isEmpty }

	public func invariant() throws {
		if !isEmpty { try requireMeaningful(name, \Self.name) }
		try validate(counter, at: \Self.counter)
	}
}
