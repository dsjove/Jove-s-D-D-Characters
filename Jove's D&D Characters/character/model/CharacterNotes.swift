import Foundation

public struct CharacterNotes: Codable, Sendable, EmptyCheckable, InvariantCheckable {
	public let dashboard: [DetailedSection]
	public let reminders: [String] // P/G/S — player/GM notes; may be updated during play
	public let campaign: [String] // P/G/S — player/GM notes; may be updated during play

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

	public func invariant() throws {
		try validate(dashboard, at: \Self.dashboard)
	}
}
