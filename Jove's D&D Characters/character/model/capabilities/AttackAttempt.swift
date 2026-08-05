import Foundation

public struct AttackAttempt: Codable, Sendable, EmptyCheckable {
	public static let attackDie = Attack.attackDie
	public let attack: Attack
	public let rollMode: RollMode
	public let cover: Cover
	public let targetArmorClass: Int?
	public let situationalAttackModifier: Int
	public let rolls: [Int]
	public let selectedDie: Int?
	public let attackTotal: Int?
	public let outcome: Outcome

	public init(
		_ attack: Attack = .init(),
		rollMode: RollMode = .normal,
		cover: Cover = .none,
		targetArmorClass: Int? = nil,
		situationalAttackModifier: Int = 0,
		rolls: [Int] = [],
		selectedDie: Int? = nil,
		attackTotal: Int? = nil,
		outcome: Outcome = .unresolved
	) {
		self.attack = attack
		self.rollMode = rollMode
		self.cover = cover
		self.targetArmorClass = targetArmorClass.map { max(0, $0) }
		self.situationalAttackModifier = situationalAttackModifier
		self.rolls = rolls.map { min(max($0, 1), Self.attackDie.sides) }
		self.selectedDie = selectedDie.map { min(max($0, 1), Self.attackDie.sides) }
		self.attackTotal = attackTotal
		self.outcome = outcome
	}

	public var effectiveArmorClass: Int? {
		targetArmorClass.map { $0 + cover.armorClassBonus }
	}

	public var isEmpty: Bool {
		attack.isEmpty && targetArmorClass == nil && situationalAttackModifier == 0 && rolls.isEmpty && selectedDie == nil && attackTotal == nil && outcome == .unresolved
	}
}

public extension AttackAttempt {
	enum RollMode: String, JCSEnum {
		case normal
		case advantage
		case disadvantage
	}

	enum Cover: String, JCSEnum {
		case none
		case half
		case threeQuarters
		case total

		public var armorClassBonus: Int {
			switch self {
			case .none, .total:
				0
			case .half:
				2
			case .threeQuarters:
				5
			}
		}

		public var preventsDirectTargeting: Bool {
			self == .total
		}
	}

	enum Outcome: String, JCSEnum {
		case unresolved
		case invalidTarget
		case miss
		case hit
		case criticalHit
		case criticalMiss
	}
}
