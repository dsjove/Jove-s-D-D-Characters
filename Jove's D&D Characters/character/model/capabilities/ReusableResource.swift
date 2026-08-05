import Foundation

public struct ReusableResource: Codable, Sendable, EmptyCheckable {
	public let name: String
	public let counter: ResourceCounter
	public let notes: [String]

	public init(_ name: String = "", counter: ResourceCounter = .init(), notes: [String] = []) {
		self.name = name
		self.counter = counter
		self.notes = notes
	}

	public var isEmpty: Bool { name.isEmpty && counter.isEmpty && notes.isEmpty }
}
