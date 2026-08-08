import Foundation

public protocol StringPresentable {
	var description: String { get }
	var abbreviation: String { get }
	var multiLineDescription: String { get }

	func description(jargon: any Jargon) -> String
	func abbreviation(jargon: any Jargon) -> String
	func multiLineDescription(jargon: any Jargon) -> String
}

public extension String {
	var multiLineDescription: String {
		replacingOccurrences(of: " ", with: "\n")
	}
}

public extension StringPresentable {
	func description(jargon: any Jargon) -> String { description }

	var abbreviation: String { description }

	func abbreviation(jargon: any Jargon) -> String { abbreviation }

	var multiLineDescription: String {
		description.replacingOccurrences(of: " ", with: "\n")
	}

	func multiLineDescription(jargon: any Jargon) -> String {
		multiLineDescription
	}
}

public extension StringPresentable where Self: RawRepresentable, Self.RawValue == String {
	nonisolated var description: String { rawValue.uncamelCased }
}
