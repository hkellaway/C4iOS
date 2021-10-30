//
//
//  Math.swift
//  C4rk
//
// Copyright (c) 2021 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

import Foundation

/// Clamps provided value to a range.
///
/// If the value is less than the lower bound, returns min, if the value is greater than
/// the upper bound, returns max, otherwise it returns the value.
///
/// Example: clamp(10, 0, 5) = 5; clamp(10, 0, 20) = 10; clamp(10, 20, 30) = 20
///
/// - returns: Clamped value.
///
public func clamp<T: Comparable>(_ val: T, range: ClosedRange<T>) -> T {
    if val < range.lowerBound { return range.lowerBound }
    if val > range.upperBound { return range.upperBound }
    return val
}

/// Return a random Double in the given range.
///
/// - parameter range: range of values
///
/// - returns: A random Double uniformly distributed between 0 and 1
///
public func random(in range: Range<Double>) -> Double {
    let intRange: Range<Double> = Double(-Int.max) ..< Double(Int.max) + 1
    let r = Double(random())
    return linearMap(r, from: intRange, to: range)
}

/// A random integer in the given range.
///
/// - parameter range: Range containing randome value.
///
/// - returns: A random value greater than or equal to lowerBound and less than upperBound.
///
public func random(in range: Range<Int>) -> Int {
    return range.lowerBound + random(below: range.upperBound - range.lowerBound)
}

/// A random integer below provided bound.
///
/// - parameter upperBound: Upper bound of random value.
///
/// - returns: A random value in the range `0..<upperBound`
///
public func random(below upperBound: Int) -> Int {
    return abs(random()) % upperBound
}

/// A random integer.
///
/// - returns: A random integer.
///
public func random() -> Int {
    var r = 0
    withUnsafeMutableBytes(of: &r) { bufferPointer in
        arc4random_buf(bufferPointer.baseAddress, MemoryLayout<Int>.size)
    }
    return r
}

/// Linear mapping. Maps a value in the source range [min,max) to a value in the target range using linear interpolation.
///
/// Example: map(10, 0..<20, 0..<200) = 100; map(10, 0..<100, 200..<300) = 210
///
/// - parameter val: Value.
/// - parameter from: From range.
/// - parameter to: Target range.
///
/// - returns: Linear mapping.
///
public func linearMap<T: FloatingPoint>(_ val: T, from: Range<T>, to: Range<T>) -> T {
    let param = (val - from.lowerBound) / (from.upperBound -  from.lowerBound)
    return lerp(to.lowerBound, to.upperBound, at: param)
}

/// Linear mapping. Maps a value in the source range [min,max] to a value in the target range using linear interpolation.
///
/// Example: map(10, 0..<20, 0..<200) = 100; map(10, 0..<100, 200..<300) = 210
///
/// - parameter val: Value.
/// - parameter from: From range.
/// - parameter to: Target range.
///
/// - returns: Linear mapping.
///
public func linearMap<T: FloatingPoint>(_ val: T, from: ClosedRange<T>, to: ClosedRange<T>) -> T {
    let param = (val - from.lowerBound) / (from.upperBound - from.lowerBound)
    return lerp(to.lowerBound, to.upperBound, at: param)
}

/// Linter interpolation between two values.
///
/// Example: lerp(0, 100, 0.5) = 50; lerp(100, 200, 0.5)  = 150; lerp(500, 1000, 0.33) = 665
///
/// - parameter a: First value.
/// - parameter b: Second value.
/// - parameter param: Value between 0 and 1 for interpolation.
///
/// - returns: Linear interpolation.
///
public func lerp<T: FloatingPoint>(_ a: T, _ b: T, at param: T) -> T {
    return a + (b - a) * param
}

/// Converts radian values to degrees. Uses the following equation: radians * 180.0 / PI
///
/// Example: radToDeg(Double.pi) = 180; radToDeg(Double.pi / 2.0) = 90
///
/// - parameter radians: Value in radians.
///
/// - returns: Radian value as degrees.
///
public func radToDeg(_ radians: Double) -> Double {
    return 180.0 * radians / Double.pi
}

/// Converts degree values to radians. Uses the following equation: value * PI / 180.0
///
/// - parameter degrees: Value in degrees.
///
/// - returns: Degree value as radians.
///
public func degToRad(_ degrees: Double) -> Double {
    return Double.pi * degrees / 180.0
}
