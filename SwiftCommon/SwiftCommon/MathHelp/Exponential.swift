
import Accelerate

// MARK: Exponentiation

public func exp(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvexpf(&results, x, [Int32(x.count)])

    return results
}

public func exp(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvexp(&results, x, [Int32(x.count)])

    return results
}

// MARK: Square Exponentiation

public func exp2(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvexp2f(&results, x, [Int32(x.count)])

    return results
}

public func exp2(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvexp2(&results, x, [Int32(x.count)])

    return results
}

// MARK: Natural Logarithm

public func log(x: [Float]) -> [Float] {
    var results = [Float](x)
    vvlogf(&results, x, [Int32(x.count)])

    return results
}

public func log(x: [Double]) -> [Double] {
    var results = [Double](x)
    vvlog(&results, x, [Int32(x.count)])

    return results
}

// MARK: Base-2 Logarithm

public func log2(x: [Float]) -> [Float] {
    var results = [Float](x)
    vvlog2f(&results, x, [Int32(x.count)])

    return results
}

public func log2(x: [Double]) -> [Double] {
    var results = [Double](x)
    vvlog2(&results, x, [Int32(x.count)])

    return results
}

// MARK: Base-10 Logarithm

public func log10(x: [Float]) -> [Float] {
    var results = [Float](x)
    vvlog10f(&results, x, [Int32(x.count)])

    return results
}

public func log10(x: [Double]) -> [Double] {
    var results = [Double](x)
    vvlog10(&results, x, [Int32(x.count)])

    return results
}

// MARK: Logarithmic Exponentiation

public func logb(x: [Float]) -> [Float] {
    var results = [Float](x)
    vvlogbf(&results, x, [Int32(x.count)])

    return results
}

public func logb(x: [Double]) -> [Double] {
    var results = [Double](x)
    vvlogb(&results, x, [Int32(x.count)])

    return results
}
