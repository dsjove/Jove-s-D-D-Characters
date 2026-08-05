import Foundation

public struct CharacterNotes: Codable, Sendable, EmptyCheckable {
	public let dashboard: [DetailedSection]
	public let reminders: [String]
	public let campaign: [String]

	public init(
		dashboard: [DetailedSection] = .init(),
		reminders: [String] = .init(),
		campaign: [String] = .init()
	) {
		self.dashboard = dashboard
		self.reminders = reminders
		self.campaign = campaign
	}

	public var isEmpty: Bool {
		dashboard.isEffectivelyEmpty && reminders.isEmpty && campaign.isEmpty
	}
}
