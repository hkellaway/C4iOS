//
//
//  SizeTests.swift
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

final class SizeTests: XCTestCase {
    
    func test_zero_hasZeroWidthAndHeight() {
        let zero: Size = .zero
        XCTAssertEqual(zero.width, 0)
        XCTAssertEqual(zero.height, 0)
    }
    
    func test_area_withNonNegativeDimensions_isDimensionsMultiplied() {
        let size1 = Size(3, 4)
        let size2 = Size(6, 5)
        let zero: Size = .zero
        XCTAssertEqual(size1.area(), 12)
        XCTAssertEqual(size2.area(), 30)
        XCTAssertEqual(zero.area(), 0)
    }
    
    func test_area_withNegativeDimensions_isNil() {
        let size1 = Size(-3, 4)
        let size2 = Size(6, -5)
        XCTAssertNil(size1.area())
        XCTAssertNil(size2.area())
    }
    
    func test_equality_withEqualSizes_isTrue() {
        XCTAssertEqual(Size(1, 2), Size(1, 2))
    }
    
    func test_equality_withNonEqualSizes_isFalse() {
        XCTAssertFalse(Size(1, 2) == Size(2, 1))
    }
    
    func test_comparison_lte() {
        XCTAssert(Size(3, 4) <= Size(3, 4))
        XCTAssert(Size(3, 4) < Size(3, 5))
    }
    
    func test_comparison_gte() {
        XCTAssert(Size(3, 4) >= Size(3, 4))
        XCTAssert(Size(3, 5) > Size(3, 4))
    }
    
}
