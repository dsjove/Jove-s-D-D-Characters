import Foundation

public enum UnitCategory: String, JCSEnum {
	case length
	case time
	case volume
	case weight
}

public enum MeasurementSystem: String, JCSEnum {
	case metric
	case imperial
	case universal
}

public protocol UnitType: JCSEnum {
	var toBase: Double { get }
	var measurementSystem: MeasurementSystem { get }
	var stepAmount: Double { get }
	var abbreviation: String { get }
	var useFractionalUnits: Bool { get }
	var significantDigits: Int { get }
}

public enum LengthUnit: String, UnitType {
	case millimeter
	case centimeter
	case meter
	case kilometer
	case inch
	case foot
	case yard
	case mile

	public var toBase: Double {
		switch self {
		case .millimeter: return 1
		case .centimeter: return 10
		case .meter: return 1_000
		case .kilometer: return 1_000_000
		case .inch: return 25.4
		case .foot: return 304.8
		case .yard: return 914.4
		case .mile: return 1_609_344
		}
	}

	public var measurementSystem: MeasurementSystem {
		switch self {
		case .millimeter, .centimeter, .meter, .kilometer: return .metric
		case .inch, .foot, .yard, .mile: return .imperial
		}
	}

	public var stepAmount: Double {
		switch self {
		case .millimeter: return 1
		case .centimeter: return 0.1
		case .meter, .kilometer: return 0.01
		case .inch: return 0.125
		case .foot, .yard: return 0.25
		case .mile: return 0.1
		}
	}

	public var abbreviation: String {
		switch self {
		case .millimeter: return "mm"
		case .centimeter: return "cm"
		case .meter: return "m"
		case .kilometer: return "km"
		case .inch: return "in."
		case .foot: return "ft."
		case .yard: return "yd."
		case .mile: return "mi."
		}
	}
}

public enum WeightUnit: String, UnitType {
	case gram
	case kilogram
	case ounce
	case pound

	public var toBase: Double {
		switch self {
		case .gram: 1
		case .kilogram: 1000
		case .ounce: 28.3495
		case .pound: 453.592
		}
	}

	public var measurementSystem: MeasurementSystem {
		switch self {
		case .gram, .kilogram: .metric;
		case .ounce, .pound: .imperial
		}
	}

	public var stepAmount: Double {
		switch self {
			case .gram: 1
			case .kilogram: 0.1
			case .ounce: 0.125
			case .pound: 0.125
		}
	}

	public var abbreviation: String {
		switch self {
		case .gram: "g"
		case .kilogram: "kg"
		case .ounce: "oz."
		case .pound: "lb."
		}
	}
}

public enum TimeUnit: String, UnitType {
	case round
	case minute
	case hour
	case day
	case year

	public var toBase: Double {
		switch self {
		case .round: return 6
		case .minute: return 60
		case .hour: return 3_600
		case .day: return 86_400
		case .year: return 31_556_952
		}
	}

	public var measurementSystem: MeasurementSystem { .universal }
	public var stepAmount: Double { 1 }
	public var useFractionalUnits: Bool { false }
	public var significantDigits: Int { 4 }

	public var abbreviation: String {
		switch self {
		case .round: return "rounds"
		case .minute: return "min."
		case .hour: return "hr."
		case .day: return "days"
		case .year: return "yr."
		}
	}
}

public enum VolumeUnit: String, UnitType {
	case milliliter
	case liter
	case teaspoon
	case tablespoon
	case fluidOunce
	case cup
	case pint
	case gallon

	public var toBase: Double {
		switch self {
		case .milliliter: 1
		case .liter: 1000
		case .teaspoon: 4.92892
		case .tablespoon: 14.7868
		case .fluidOunce: 29.5735
		case .cup: 236.588
		case .pint: 473.176
		case .gallon: 3785.41
		}
	}

	public var measurementSystem: MeasurementSystem {
		switch self {
		case .milliliter:
			fallthrough
		case .liter:
			.metric
		default:
			.imperial
		}
	}

	public var stepAmount: Double {
		switch self {
		case .milliliter: 1
		case .liter: 0.1
		case .gallon: 0.125
		default: 0.25
		}
	}

	public var abbreviation: String {
		switch self {
		case .milliliter: "mL"
		case .liter: "L"
		case .teaspoon: "tsp."
		case .tablespoon: "tbsp."
		case .fluidOunce: "fl. oz."
		case .cup: "c."
		case .pint: "pt."
		case .gallon: "gal."
		}
	}
}

public struct Unit<Kind: UnitType>: Codable, Sendable, InvariantCheckable {
	public let value: Double // O — inherits volatility from the containing property
	public let kind: Kind // O — inherits volatility from the containing property

	public init(_ value: Double = 0, _ kind: Kind) {
		self.value = value
		self.kind = kind
	}

	public func converted(to otherKind: Kind) -> Self {
		.init(kind.convert(value, to: otherKind), otherKind)
	}

	public var description: String {
		"\(kind.format(value: value)) \(kind.abbreviation)"
	}


	public func invariant() throws {
		try require(value.isFinite, \Self.value, "must be finite")
		try require(kind.toBase.isFinite && kind.toBase > 0, \Self.kind.toBase, "must be finite and greater than 0")
		try require(kind.stepAmount.isFinite && kind.stepAmount > 0, \Self.kind.stepAmount, "must be finite and greater than 0")
	}
}

public extension UnitType {
	var useFractionalUnits: Bool { measurementSystem == .imperial }
	var significantDigits: Int { measurementSystem == .imperial ? 4 : 2 }

	func step(_ value: Double, increasing: Bool) -> Double {
		if !increasing, value.isZero { return 0.0 }
		if increasing { return (floor(value / stepAmount) + 1) * stepAmount }
		return (ceil(value / stepAmount) - 1) * stepAmount
	}

	func convert<Other: UnitType>(_ value: Double, to: Other) -> Double {
		(value * toBase) / to.toBase
	}

	func formattedConversion<Other: UnitType>(_ value: Double, to: Other) -> String {
		to.format(value: convert(value, to: to))
	}

	func format(value: Double) -> String {
		if useFractionalUnits, let fraction = fractionString(for: value) { return fraction }
		return decimalString(for: value, significantDigits: significantDigits)
	}
}

public extension UnitType where Self: RawRepresentable, RawValue == String {
	var id: String { rawValue }
	var description: String { rawValue.capitalized }
}

private func decimalString(for value: Double, significantDigits: Int) -> String {
	let formatter = NumberFormatter()
	formatter.numberStyle = .decimal
	formatter.usesSignificantDigits = true
	formatter.maximumSignificantDigits = max(1, significantDigits)
	formatter.minimumSignificantDigits = 1
	return formatter.string(from: value as NSNumber) ?? "\(value)"
}

private func fractionString(for value: Double) -> String? {
	if value.isNaN || value.isInfinite { return nil }
	let absValue = abs(value)
	if absValue > 10_000 { return nil }
	let whole = Int(value.rounded(.towardZero))
	let fractional = abs(value - Double(whole))
	if fractional.isApproximatelyZero(epsilon: 1e-6) { return "\(whole)" }
	let denominators = [2, 3, 4, 5, 6, 8, 10, 12, 16]
	var bestNumerator: Int?
	var bestDenominator: Int?
	var bestError = Double.greatestFiniteMagnitude
	for denominator in denominators {
		let numerator = (fractional * Double(denominator)).rounded()
		let error = abs(Double(numerator) / Double(denominator) - fractional)
		if error < bestError { bestError = error; bestNumerator = Int(numerator); bestDenominator = denominator }
	}
	guard let numerator = bestNumerator, let denominator = bestDenominator, bestError < 0.01 else { return nil }
	var carryWhole = whole
	var num = numerator
	var den = denominator
	if num == den { carryWhole += value >= 0 ? 1 : -1; num = 0 }
	if num != 0 { let divisor = gcd(abs(num), den); num /= divisor; den /= divisor }
	let sign = value < 0 && carryWhole == 0 && num > 0 ? "-" : ""
	if num == 0 { return "\(carryWhole)" }
	if carryWhole == 0 { return "\(sign)\(num)/\(den)" }
	return "\(carryWhole) \(num)/\(den)"
}

private func gcd(_ a: Int, _ b: Int) -> Int {
	var x = a; var y = b
	while y != 0 { let remainder = x % y; x = y; y = remainder }
	return max(1, x)
}

private extension Double {
	func isApproximatelyZero(epsilon: Double) -> Bool { abs(self) < epsilon }
}
