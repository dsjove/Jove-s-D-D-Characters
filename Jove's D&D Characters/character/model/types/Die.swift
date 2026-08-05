import Foundation

public enum Die: Int, JCSEnum {
	case d0   = 0
	case d1   = 1
	case d2   = 2
	case d4   = 4
	case d6   = 6
	case d8   = 8
	case d10  = 10
	case d12  = 12
	case d20  = 20
	case d100 = 100

	public var sides: Int {
		rawValue
	}

	public func roll(count: Int = 1) -> Int {
		guard count > 0 else { return 0 }
		return (0..<count).reduce(0) { total, _ in total + rollOnce() }
	}

	private func rollOnce() -> Int {
		guard sides > 0 else { return 0 }
		return Int.random(in: 1...sides)
	}
}

extension Die {
	public var description: String {
		"d\(sides)"
	}
}

public struct Dice: Codable, Sendable, EmptyCheckable {
	public let number: Int
	public let type: Die

	public init(
		_ number: Int = 1,
		_ type: Die = .d0
	) {
		self.number = max(0, number)
		self.type = type
	}

	public var isEmpty: Bool {
		number == 0 || type == .d0
	}
}

extension Dice: StringPresentable {
	public var description: String {
		"\(number)\(type.description)"
	}
}

public struct Roll: Codable, Sendable, EmptyCheckable {
	public let dice: [Dice]
	public let modifier: Int

	public init(
		_ number: Int = 1,
		_ die: Die = .d0,
		_ modifier: Int = 0
	) {
		self.dice = die == .d0 || number == 0 ? [] : [.init(number, die)]
		self.modifier = modifier
	}

	public init(
		dice: [Dice],
		modifier: Int = 0
	) {
		self.dice = dice
		self.modifier = modifier
	}

	public var isEmpty: Bool {
		dice.isEffectivelyEmpty && modifier == 0
	}
}

extension Roll: StringPresentable {
	public var description: String {
		let diceDescription = dice.map(\.description).joined(separator: " + ")
		let sheetModifierDescription = modifier.modifierDescription
		return [diceDescription, sheetModifierDescription]
			.filter { !$0.isEmpty }
			.joined(separator: " ")
	}
}
