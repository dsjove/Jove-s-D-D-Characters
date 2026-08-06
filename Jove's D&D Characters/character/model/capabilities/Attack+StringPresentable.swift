import Foundation

extension Attack {
	func sheetResolutionDescription(jargon: any Jargon) -> String {
		switch resolution {
		case .attackRoll:
			attackBonus?.signedDescription() ?? jargon.missingValueText
		case .savingThrow(let ability, let dc, let result):
			"\(ability.description) \(jargon.saveDCTitle) \(dc)\n\(result.description)"
		case .automatic:
			jargon.automaticTitle
		}
	}

	func sheetDamageDescription(jargon: any Jargon) -> String {
		damage.map { $0.description(jargon: jargon) }.joined(separator: "\n")
	}

	func sheetDeliveryDescription(jargon: any Jargon) -> String {
		[
			delivery.description,
			range.description(jargon: jargon),
			target.description(jargon: jargon),
		]
		.filter { !$0.isEmpty }
		.joined(separator: "\n")
	}

	func sheetDetailDescription(jargon: any Jargon) -> String {
		var details: [String] = []
		if !properties.isEmpty {
			details.append(
				properties.sorted { $0.rawValue < $1.rawValue }
					.map(\.description)
					.joined(separator: ", ")
			)
		}
		details.append(contentsOf: effects.map { $0.description(jargon: jargon) }.filter { !$0.isEmpty })
		if criticalThreshold != Self.attackDie.sides {
			details.append("\(jargon.criticalOnTitle) \(criticalThreshold)–\(Self.attackDie.sides)")
		}
		if !notes.isEmpty {
			details.append(notes)
		}
		return details.joined(separator: "\n")
	}
}

extension Attack.Range: StringPresentable {
	public var description: String { kind.description }

	public func description(jargon: any Jargon) -> String {
		switch kind {
		case .reach:
			"\(jargon.reachTitle) \(normal.description)"
		case .distance:
			if let long {
				"\(jargon.rangeTitle) \(normal.kind.format(value: normal.value))/\(long.kind.format(value: long.value)) \(normal.kind.abbreviation)"
			} else {
				"\(jargon.rangeTitle) \(normal.description)"
			}
		case .selfOrigin:
			normal.value > 0
				? "\(jargon.selfTitle) (\(normal.description))"
				: jargon.selfTitle
		case .sight:
			jargon.sightTitle
		case .unlimited:
			jargon.unlimitedTitle
		}
	}
}

extension Attack.Target: StringPresentable {
	public var description: String { kind.description }

	public func description(jargon: any Jargon) -> String {
		var components: [String] = []
		if let count {
			components.append("\(count)")
		}
		switch kind {
		case .creature:
			components.append(count == 1 ? jargon.creatureTitle : jargon.creaturesTitle)
		case .object:
			components.append(count == 1 ? jargon.objectTitle : jargon.objectsTitle)
		case .creatureOrObject:
			components.append(count == 1 ? jargon.creatureOrObjectTitle : jargon.creaturesOrObjectsTitle)
		case .point:
			components.append(jargon.pointTitle)
		case .area:
			components.append(area?.description(jargon: jargon) ?? jargon.areaTitle)
		case .selfOnly:
			components.append(jargon.selfTitle)
		}
		if !restrictions.isEmpty {
			components.append(restrictions)
		}
		return components.joined(separator: " ")
	}
}

extension Attack.Area: StringPresentable {
	public var description: String { shape.description }

	public func description(jargon: any Jargon) -> String {
		switch shape {
		case .line:
			if let width {
				"\(size.description) × \(width.description) \(jargon.lineTitle)"
			} else {
				"\(size.description) \(jargon.lineTitle)"
			}
		case .cylinder:
			if let width {
				"\(size.description) × \(width.description) \(jargon.cylinderTitle)"
			} else {
				"\(size.description) \(jargon.cylinderTitle)"
			}
		case .cone, .cube, .sphere:
			"\(size.description) \(shape.description.lowercased())"
		}
	}
}

extension Attack.Damage: StringPresentable {
	public var description: String { "\(roll.description) \(type.description.lowercased())" }

	public func description(jargon: any Jargon) -> String {
		var result = description
		if timing != .onHit {
			result += " (\(timing.description.lowercased()))"
		}
		if !condition.isEmpty {
			result += " — \(condition)"
		}
		return result
	}
}

extension Attack.Effect: StringPresentable {
	public func description(jargon: any Jargon) -> String {
		var components: [String] = []
		if trigger != .onHit {
			components.append(trigger.description)
		}
		if let condition {
			components.append(condition.description)
		}
		if let savingThrow {
			components.append(savingThrow.description(jargon: jargon))
		}
		if let duration {
			components.append(duration.description(jargon: jargon))
		}
		if !description.isEmpty {
			components.append(description)
		}
		return components.joined(separator: "; ")
	}
}

extension Attack.SavingThrow: StringPresentable {
	public var description: String {
		[ability.description, dc.map { "DC \($0)" }]
			.compactMap { $0 }
			.joined(separator: " ")
	}

	public func description(jargon: any Jargon) -> String {
		[
			dc.map { "\(ability.description) \(jargon.saveDCTitle) \($0)" } ?? ability.description,
			timing == .whenApplied ? "" : timing.description,
			"\(jargon.successTitle): \(success.description.lowercased())",
		]
		.filter { !$0.isEmpty }
		.joined(separator: ", ")
	}
}

extension Attack.Duration: StringPresentable {
	public var description: String {
		switch self {
		case .instantaneous: "Instantaneous"
		case .untilStartOfNextTurn: "Until start of next turn"
		case .untilEndOfNextTurn: "Until end of next turn"
		case .rounds(let count): "\(count) \(count == 1 ? "round" : "rounds")"
		case .minutes(let count): "\(count) \(count == 1 ? "minute" : "minutes")"
		case .hours(let count): "\(count) \(count == 1 ? "hour" : "hours")"
		case .untilSaveSucceeds: "Until save succeeds"
		case .permanent: "Permanent"
		case .special(let description): description
		}
	}

	public func description(jargon: any Jargon) -> String {
		switch self {
		case .instantaneous: jargon.instantaneousTitle
		case .untilStartOfNextTurn: jargon.untilStartOfNextTurnTitle
		case .untilEndOfNextTurn: jargon.untilEndOfNextTurnTitle
		case .rounds(let count): "\(count) \(count == 1 ? jargon.roundTitle : jargon.roundsTitle)"
		case .minutes(let count): "\(count) \(count == 1 ? jargon.minuteTitle : jargon.minutesTitle)"
		case .hours(let count): "\(count) \(count == 1 ? jargon.hourTitle : jargon.hoursTitle)"
		case .untilSaveSucceeds: jargon.untilSaveSucceedsTitle
		case .permanent: jargon.permanentTitle
		case .special(let description): description
		}
	}
}

extension Attack.Ability {
	public var abbreviation: String { String(rawValue.prefix(3)).uppercased() }
}

