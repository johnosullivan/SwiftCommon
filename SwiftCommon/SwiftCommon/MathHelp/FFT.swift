

import Accelerate

// MARK: Fast Fourier Transform

public func fft(input: [Float]) -> [Float] {
    var real = [Float](input)
    var imaginary = [Float](count: input.count, repeatedValue: 0.0)
    var splitComplex = DSPSplitComplex(realp: &real, imagp: &imaginary)

    let length = vDSP_Length(floor(log2(Float(input.count))))
    let radix = FFTRadix(kFFTRadix2)
    let weights = vDSP_create_fftsetup(length, radix)
    vDSP_fft_zip(weights, &splitComplex, 1, length, FFTDirection(FFT_FORWARD))

    var magnitudes = [Float](count: input.count, repeatedValue: 0.0)
    vDSP_zvmags(&splitComplex, 1, &magnitudes, 1, vDSP_Length(input.count))

    var normalizedMagnitudes = [Float](count: input.count, repeatedValue: 0.0)
    vDSP_vsmul(sqrt(magnitudes), 1, [2.0 / Float(input.count)], &normalizedMagnitudes, 1, vDSP_Length(input.count))

    vDSP_destroy_fftsetup(weights)

    return normalizedMagnitudes
}

public func fft(input: [Double]) -> [Double] {
    var real = [Double](input)
    var imaginary = [Double](count: input.count, repeatedValue: 0.0)
    var splitComplex = DSPDoubleSplitComplex(realp: &real, imagp: &imaginary)

    let length = vDSP_Length(floor(log2(Float(input.count))))
    let radix = FFTRadix(kFFTRadix2)
    let weights = vDSP_create_fftsetupD(length, radix)
    vDSP_fft_zipD(weights, &splitComplex, 1, length, FFTDirection(FFT_FORWARD))

    var magnitudes = [Double](count: input.count, repeatedValue: 0.0)
    vDSP_zvmagsD(&splitComplex, 1, &magnitudes, 1, vDSP_Length(input.count))

    var normalizedMagnitudes = [Double](count: input.count, repeatedValue: 0.0)
    vDSP_vsmulD(sqrt(magnitudes), 1, [2.0 / Double(input.count)], &normalizedMagnitudes, 1, vDSP_Length(input.count))

    vDSP_destroy_fftsetupD(weights)

    return normalizedMagnitudes
}
