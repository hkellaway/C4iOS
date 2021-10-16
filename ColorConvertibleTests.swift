//
//
//  ColorConvertibleTests.swift
//  C4
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

final class ColorConvertibleTests: XCTestCase {
    
    let hexColor: HexColor = "#C4ABCD"
    let rgbColor: RGBColor = "(196, 171, 205)"
    let uiColor = UIColor(red: 196 / 255, green: 171 / 255, blue: 205 / 255, alpha: 1)
    
    func test_isEqual_hexColor_rgbColor() {
        XCTAssert(hexColor.isEqual(to: rgbColor))
        XCTAssert(rgbColor.isEqual(to: hexColor))
    }
    
    func test_isEqual_hexColor_uiColor() {
        XCTAssert(hexColor.isEqual(to: uiColor))
        XCTAssert(uiColor.isEqual(to: hexColor))
    }
    
    func test_isEqual_rgbColor_uiColor() {
        XCTAssert(rgbColor.isEqual(to: uiColor))
        XCTAssert(uiColor.isEqual(to: rgbColor))
    }
    
    func test_isEqual_validArrays_isTrue() {
        let array1: [ColorConvertible] = [hexColor, rgbColor, uiColor]
        let array2: [ColorConvertible] = [hexColor, rgbColor, uiColor]
        XCTAssert(array1.isEqual(to: array2))
        XCTAssert(array2.isEqual(to: array1))
    }
    
    func test_isEqual_invalidArrays_isFalse() {
        let array1: [ColorConvertible] = [hexColor, rgbColor, uiColor]
        let array2: [ColorConvertible] = [rgbColor, uiColor, hexColor]
        XCTAssertFalse(array1.isEqual(to: array2))
        XCTAssertFalse(array2.isEqual(to: array1))
    }
    
}
