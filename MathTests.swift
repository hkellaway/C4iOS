//
//
//  MathTests.swift
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

import C4rk
import XCTest

class MathTests: XCTestCase {
    
    func test_clamp_whenValueWithinRange_isValue() {
        let min = 0
        let max = 20
        let value = (max - min) / 2
        XCTAssertEqual(clamp(value, range: min...max), value)
    }
    
    func test_clamp_whenValueLessThanMin_isMin() {
        let min = 20
        let max = 30
        let value = min - 10
        XCTAssertEqual(clamp(value, range: min...max), min)
    }
    
    func test_clamp_whenValueGreatherThanMax_isMax() {
        let min = 0
        let max = 5
        let value = max + 10
        XCTAssertEqual(clamp(value, range: min...max), max)
    }
    
    func test_lerp() {
        XCTAssertEqual(lerp(0, 100, at: 0.5), 50)
        XCTAssertEqual(lerp(100, 200, at: 0.5), 150)
        XCTAssertEqual(lerp(500, 1000, at: 0.33), 665)
    }
    
    func test_linearMap_unclosedRange() {
        XCTAssertEqual(linearMap(10, from: 0..<20, to: 0..<200), 100)
        XCTAssertEqual(linearMap(10, from: 0..<100, to: 200..<300), 210)
        XCTAssertEqual(linearMap(10, from: 0..<20, to: 200..<300), 250)
    }
    
    func test_linearMap_closedRange() {
        XCTAssertEqual(linearMap(10, from: 0...20, to: 0...200), 100)
        XCTAssertEqual(linearMap(10, from: 0...100, to: 200...300), 210)
        XCTAssertEqual(linearMap(10, from: 0...20, to: 200...300), 250)
    }
    
    func test_radToDeg() {
        XCTAssertEqual(radToDeg(Double.pi), 180)
        XCTAssertEqual(radToDeg(Double.pi / 2.0), 90)
    }
    
    func testDegToRad() {
        XCTAssertEqual(degToRad(270), 4.71238898038469)
        XCTAssertEqual(degToRad(360), 6.283185307179586)
    }
    
}
