//
//
//  ColorTests.swift
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

final class ColorTests: XCTestCase {
    
    func test_setRed_validValue() {
        let valid: CGFloat = 234 / 255
        let color = Color()!
        color.red = valid
        XCTAssertEqual(color.red, valid)
    }
    
    func test_setRed_invalidValue() {
        let valid: CGFloat = 234 / 255
        let invalid: CGFloat = 2340
        let color = Color(red: valid, green: valid, blue: valid)!
        color.red = invalid
        XCTAssertEqual(color.red, valid)
    }
    
    func test_setGreen_validValue() {
        let valid: CGFloat = 234 / 255
        let color = Color()!
        color.green = valid
        XCTAssertEqual(color.green, valid)
    }
    
    func test_setGreen_invalidValue() {
        let valid: CGFloat = 234 / 255
        let invalid: CGFloat = 2340
        let color = Color(red: valid, green: valid, blue: valid)!
        color.green = invalid
        XCTAssertEqual(color.green, valid)
    }
    
    func test_setBlue_validValue() {
        let valid: CGFloat = 234 / 255
        let color = Color()!
        color.blue = valid
        XCTAssertEqual(color.blue, valid)
    }
    
    func test_setBlue_invalidValue() {
        let valid: CGFloat = 234 / 255
        let invalid: CGFloat = 2340
        let color = Color(red: valid, green: valid, blue: valid)!
        color.blue = invalid
        XCTAssertEqual(color.blue, valid)
    }

    func test_hue_whenAllComponentsEqual() {
        let color = Color()!
        color.red = 123 / 255
        color.green = 123 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.hue, 0)
    }
    
    func test_hue_whenRedIsMin() {
        let color = Color()!
        color.red = 0 / 255
        color.green = 100 / 255
        color.blue = 200 / 255
        XCTAssertEqual(color.hue, 0.5833333333333334)
    }
    
    func test_hue_whenGreenIsMin() {
        let color = Color()!
        color.red = 100 / 255
        color.green = 0 / 255
        color.blue = 200 / 255
        XCTAssertEqual(color.hue, 0.75)
    }
    
    func test_hue_whenBlueIsMin() {
        let color = Color()!
        color.red = 100 / 255
        color.green = 200 / 255
        color.blue = 0 / 255
        XCTAssertEqual(color.hue, 0.25)
    }
    
    func test_saturation_whenAllComponentsEqual() {
        let color = Color()!
        color.red = 123 / 255
        color.green = 123 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.saturation, 0)
    }
    
    func test_saturation_whenRedIsMin() {
        let color = Color()!
        color.red = 12 / 255
        color.green = 34 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.saturation, 0.9024390243902439)
    }
    
    func test_saturation_whenGreenIsMin() {
        let color = Color()!
        color.red = 34 / 255
        color.green = 12 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.saturation, 0.9024390243902439)
    }
    
    func test_saturation_whenBlueIsMin() {
        let color = Color()!
        color.red = 34 / 255
        color.green = 123 / 255
        color.blue = 12 / 255
        XCTAssertEqual(color.saturation, 0.9024390243902439)
    }
    
    func test_brightness_whenAllComponentsEqual() {
        let color = Color()!
        color.red = 123 / 255
        color.green = 123 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.brightness, 0.4823529411764706)
    }
    
    func test_brightness_whenRedIsMin() {
        let color = Color()!
        color.red = 12 / 255
        color.green = 34 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.brightness, 0.4823529411764706)
    }
    
    func test_brightness_whenGreenIsMin() {
        let color = Color()!
        color.red = 34 / 255
        color.green = 12 / 255
        color.blue = 123 / 255
        XCTAssertEqual(color.brightness, 0.4823529411764706)
    }
    
    func test_brightness_whenBlueIsMin() {
        let color = Color()!
        color.red = 34 / 255
        color.green = 123 / 255
        color.blue = 12 / 255
        XCTAssertEqual(color.brightness, 0.4823529411764706)
    }
    
}
