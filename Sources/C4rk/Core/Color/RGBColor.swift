//
//
//  RGBColor.swift
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

/// Color representable by an RGB value (ex. (0, 10, 200).
public struct RGBColor: ColorConvertible, CustomStringConvertible, Equatable, ExpressibleByStringLiteral {
    
    // MARK: - Properties
    
    public let rawValue: String
    public let uiColor: UIColor
    
    public var isInvalid: Bool {
        return rawValue == kInvalidColorIdentifier
    }
    
    public var description: String {
        return rawValue
    }
    
    // MARK: - Init/Deinit
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(stringLiteral: value, alpha: 1.0)
    }
    
    public init(stringLiteral value: StringLiteralType,
                alpha: CGFloat = 1.0,
                numberFormatter: NumberFormatter = NumberFormatter()) {
        guard AlphaValue.contains(alpha) else {
            // TODO: Use Logger
            print("Failed to initialize `RGBColor using alpha '\(alpha)'.`")
            self.init(rawValue: kInvalidColorIdentifier, uiColor: .invalid)
            return
        }
        
        numberFormatter.maximumIntegerDigits = 3
        numberFormatter.maximumFractionDigits = 0
        let rgb: [CGFloat] = value.trimmingCharacters(in: .whitespacesAndNewlines)
            .dropFirst(1)
            .dropLast(1)
            .split(separator: ",")
            .map(String.init)
            .compactMap { CGFloat(string: $0, numberFormatter: numberFormatter) }
            .filter { RGBValue.contains($0) }
        
        guard rgb.count == 3 else {
            // TODO: Use Logger
            print("[C4rk] Failed to initialize `RGBColor` using string literal '\(value)'.")
            self.init(rawValue: kInvalidColorIdentifier, uiColor: .invalid)
            return
        }
        
        let uiColor = UIColor(red: rgb[0] / CGFloat(RGBValue.upperBound),
                              green: rgb[1] / CGFloat(RGBValue.upperBound),
                              blue: rgb[2] / CGFloat(RGBValue.upperBound),
                              alpha: alpha)
        self.init(rawValue: value, uiColor: uiColor)
    }
    
    private init(rawValue: String, uiColor: UIColor) {
        self.rawValue = rawValue
        self.uiColor = uiColor
    }
    
}

// MARK: - Protocol conformance

// MARK: Equatable

extension RGBColor {
    
    public static func ==(lhs: RGBColor, rhs: RGBColor) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
}
