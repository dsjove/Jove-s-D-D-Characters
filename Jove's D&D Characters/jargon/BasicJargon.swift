import Foundation

public struct BasicJargon: Jargon {
	public let name: String

	public init(_ name: String = "Basic") {
		self.name = name
	}
}
