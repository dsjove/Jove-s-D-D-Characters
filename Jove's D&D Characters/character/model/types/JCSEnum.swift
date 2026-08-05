import Foundation

public protocol JCSEnum: Codable, Sendable, CaseIterable, StringPresentable, EmptyCheckable {
}

public extension JCSEnum {
	var isEmpty: Bool { false }
}

extension String {
	nonisolated var uncamelCased: String {
		guard !isEmpty else { return self }
		let characters = Array(self)
		var result = ""
		result.reserveCapacity(characters.count + characters.count / 4)
		for index in characters.indices {
			let character = characters[index]
			if character == "_" {
				if result.last != " " { result.append(" ") }
				continue
			}
			if index > characters.startIndex {
				let previous = characters[index - 1]
				let next = index + 1 < characters.endIndex ? characters[index + 1] : nil
				let startsNewWord = character.isUppercase && previous != "_" && (
					previous.isLowercase || previous.isNumber ||
					(previous.isUppercase && next?.isLowercase == true)
				)
				if startsNewWord, result.last != " " { result.append(" ") }
			}
			result.append(character)
		}
		return result.prefix(1).uppercased() + result.dropFirst()
	}
}
