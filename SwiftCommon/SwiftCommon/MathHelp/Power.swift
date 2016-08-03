

import Accelerate

// MARK: Power

public func pow(x: [Float], y: [Float]) -> [Float] {
    var results = [Float](count: x.count, repeatedValue: 0.0)
    vvpowf(&results, x, y, [Int32(x.count)])

    return results
}

public func pow(x: [Double], y: [Double]) -> [Double] {
    var results = [Double](count: x.count, repeatedValue: 0.0)
    vvpow(&results, x, y, [Int32(x.count)])

    return results
}

public func pow(x: [Float], _ y: Float) -> [Float] {
    let yVec = [Float](count: x.count, repeatedValue: y)
    return pow(yVec, y: x)
}

public func pow(x: [Double], _ y: Double) -> [Double] {
    let yVec = [Double](count: x.count, repeatedValue: y)
    return pow(yVec, y: x)
}
