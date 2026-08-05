import Foundation

public enum AdvancementMethod: String, JCSEnum {
	case experience
	case milestone
	case other
}

public struct Advancement: Codable, Sendable, EmptyCheckable {
	public let method: AdvancementMethod?
	public let currentxperience: Int?
	public let nextLevelExperience: Int?
	public let milestoneProgress: String
	public let feats: [String]
	public let abilityScoreImprovements: [String]
	public let notes: [String]

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
}
