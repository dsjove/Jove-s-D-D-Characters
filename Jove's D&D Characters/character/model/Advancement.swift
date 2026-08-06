import Foundation

public enum AdvancementMethod: String, JCSEnum {
	case experience
	case milestone
	case other
}

public struct Advancement: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let method: AdvancementMethod? // P/G — player/GM campaign choice
	public let currentxperience: Int? // A+S/G — updated as advancement is awarded; range: 0... when set
	public let nextLevelExperience: Int? // H→A — rules threshold for advancement; range: 0... when set
	public let milestoneProgress: String // A+S/G — updated as advancement is awarded
	public let feats: [String] // H+P→A — rules options selected at advancement
	public let abilityScoreImprovements: [String] // H+P→A — rules options selected at advancement
	public let notes: [String] // P/G — advancement notes

	public init(
		method: AdvancementMethod? = nil,
		currentxperience: Int? = nil,
		nextLevelExperience: Int? = nil,
		milestoneProgress: String = "",
		feats: [String] = [],
		abilityScoreImprovements: [String] = [],
		notes: [String] = []
	) {
		self.method = method
		self.currentxperience = currentxperience
		self.nextLevelExperience = nextLevelExperience.map { max($0, 0) }
		self.milestoneProgress = milestoneProgress
		self.feats = feats
		self.abilityScoreImprovements = abilityScoreImprovements
		self.notes = notes
	}

	public var isEmpty: Bool {
		method == nil && currentxperience == nil && nextLevelExperience == nil && milestoneProgress.isEmpty && feats.isEmpty && abilityScoreImprovements.isEmpty && notes.isEmpty
	}


	public func invariant() throws {
		if let currentxperience { try require(currentxperience >= 0, \Self.currentxperience, "must be at least 0") }
		if let nextLevelExperience { try require(nextLevelExperience >= 0, \Self.nextLevelExperience, "must be at least 0") }
	}
}
