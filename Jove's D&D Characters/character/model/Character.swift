import Foundation

public struct Character: Codable, Sendable, EmptyCheckable {
	public let person: Person
	public let life: Life
	public let capabilities: Capabilities
	public let possessions: Possessions
	public let advancement: Advancement
	public let notes: CharacterNotes

	public init(
		person: Person = .init(),
		life: Life = .init(),
		capabilities: Capabilities = .init(),
		possessions: Possessions = .init(),
		advancement: Advancement = .init(),
		notes: CharacterNotes = .init()
	) {
		self.person = person
		self.life = life
		self.capabilities = capabilities
		self.possessions = possessions
		self.advancement = advancement
		self.notes = notes
	}

	public var isEmpty: Bool {
		person.isEmpty && life.isEmpty && capabilities.isEmpty && possessions.isEmpty && advancement.isEmpty && notes.isEmpty
	}
}
