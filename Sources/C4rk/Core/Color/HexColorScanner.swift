//
//
//  HexColorScanner.swift
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
import Foundation

/// Scans colors from hex code representations.
public protocol HexColorScanner {

    /// Scans an RGB color value from string in hex format.
    ///
    /// - Parameter string: String in hex format (ex. #ABCDEF).
    ///
    /// - Returns: RGB color value when successful, nil otherwise. Color values will be 0...255 and alpha 0...1.
    func rgba(fromHex string: String)
        -> Result<(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), HexColorScannerError>
    
    /// Scans an RGB color value from string in hex format.
    ///
    /// - Parameters:
    ///   - string: String in hex format (ex. #ABCDEF).
    ///   - alpha:  Alpha value of the RGB color.
    ///
    /// - Returns: RGB color value when successful, nil otherwise. Color values will be 0...255 and alpha 0...1.
    func rgba(fromHex string: String, alpha: CGFloat)
        -> Result<(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), HexColorScannerError>

}

extension HexColorScanner {
    
    public func rgba(fromHex string: String)
        -> Result<(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), HexColorScannerError> {
        self.rgba(fromHex: string, alpha: 1.0)
    }
    
}

extension Scanner: HexColorScanner {
    
    public func rgba(fromHex string: String, alpha: CGFloat)
        -> Result<(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat), HexColorScannerError> {
        guard AlphaValue.contains(alpha) else {
            return .failure(.invalidAlpha(value: alpha))
        }
            
        let withoutHashMark = string
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .dropFirst(1, if: { $0.hasPrefix("#") })
        
        guard ((withoutHashMark.count) == 6) else {
            return .failure(.invalidString(value: string))
        }
        
        var hexInt: UInt64 = 0
        
        guard Scanner(string: withoutHashMark).scanHexInt64(&hexInt) else {
            return .failure(.invalidString(value: string))
        }
        
        let red = CGFloat((hexInt & 0xFF0000) >> 16)
        let green = CGFloat((hexInt & 0x00FF00) >> 8)
        let blue = CGFloat(hexInt & 0x0000FF)
            
        guard RGBValue.contains(red) && RGBValue.contains(green) && RGBValue.contains(blue) else {
            return .failure(.invalidString(value: string))
        }
            
        return .success((r: red, g: green, b: blue, a: alpha))
    }
    
}

public enum HexColorScannerError: Error, LocalizedError {
    case invalidAlpha(value: CGFloat)
    case invalidString(value: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidAlpha(let value):
            return "Invalid alpha value: \(value)."
        case .invalidString(let value):
            return "Invalid hex string: \(value)."
        }
    }
}
