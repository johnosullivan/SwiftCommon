

import Accelerate

// MARK: Hyperbolic Sine

public func sinh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvsinhf(&results, x, [Int32(x.count)])

    return results
}

public func sinh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvsinh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Hyperbolic Cosine

public func cosh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvcoshf(&results, x, [Int32(x.count)])

    return results
}

public func cosh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvcosh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Hyperbolic Tangent

public func tanh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvtanhf(&results, x, [Int32(x.count)])

    return results
}

public func tanh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvtanh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Sine

public func asinh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvasinhf(&results, x, [Int32(x.count)])

    return results
}

public func asinh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvasinh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Cosine

public func acosh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvacoshf(&results, x, [Int32(x.count)])

    return results
}

public func acosh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvacosh(&results, x, [Int32(x.count)])

    return results
}

// MARK: Inverse Hyperbolic Tangent

public func atanh(x: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvatanhf(&results, x, [Int32(x.count)])

    return results
}

public func atanh(x: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvatanh(&results, x, [Int32(x.count)])

    return results
}
