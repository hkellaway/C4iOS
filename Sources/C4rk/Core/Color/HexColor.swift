//
//
//  HexColor.swift
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

import CoreGraphics
import UIKit

/// Color representable by a hex string (ex. #C4ABCD).
public struct HexColor: ColorConvertible, CustomStringConvertible, Equatable, ExpressibleByStringLiteral {
    
    // MARK: - Properties
    
    /// Raw string value (ex. #C4ABCD).
    public let rawValue: String
    
    /// `UIColor` representation.
    public let uiColor: UIColor
    
    public var isInvalid: Bool {
        return rawValue == kInvalidColorIdentifier
    }
    
    public var description: String {
        return rawValue
    }
    
    // MARK: - Init/Deinit
    
    /// Initializes a `HexColor` given a string value.
    /// - Parameter value: Hex string (ex. #C4ABCD).
    public init(stringLiteral value: StringLiteralType) {
        self.init(stringLiteral: value, alpha: 1.0)
    }
    
    /// Initializes a `HexColor` given a string value.
    /// - Parameters:
    ///   - value: Hex string (ex. #C4ABCD).
    ///   - alpha: Alpha value for color.
    ///   - hexScanner: Scanner to extract hex value from string.
    public init(stringLiteral value: StringLiteralType,
                alpha: CGFloat = 1.0,
                hexScanner: HexColorScanner = Scanner()) {
        guard case let .success(rgb) = hexScanner.rgba(fromHex: value, alpha: alpha) else {
            // TODO: Use Logger
            print("[C4rk] Failed to initialize `HexColor` using string literal '\(value)'.")
            self.init(rawValue: kInvalidColorIdentifier, uiColor: .invalid)
            return
        }
        
        let uiColor = UIColor(red: rgb.r / CGFloat(RGBValue.upperBound),
                              green: rgb.g / CGFloat(RGBValue.upperBound),
                              blue: rgb.b / CGFloat(RGBValue.upperBound),
                              alpha: rgb.a)
        self.init(rawValue: value, uiColor: uiColor)
    }
    
    private init(rawValue: String, uiColor: UIColor) {
        self.rawValue = rawValue
        self.uiColor = uiColor
    }
    
}

// MARK: - Protocol conformance

// MARK: Equatable

extension HexColor {
    
    public static func ==(lhs: HexColor, rhs: HexColor) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
}
