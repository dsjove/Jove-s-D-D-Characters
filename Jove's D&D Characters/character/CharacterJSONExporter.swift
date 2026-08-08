import Foundation

public enum CharacterJSONExporter {
	public static func data(for character: Character) throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
		return try encoder.encode(character)
	}

	public static func write(_ character: Character, to url: URL) throws {
		try data(for: character).write(to: url, options: .atomic)
	}
}
