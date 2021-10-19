//
//
//  Color.swift
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

import CoreGraphics
import UIKit

public class Color: ColorConvertible, CustomStringConvertible, Equatable {
    
    // MARK: - Properties
    
    public var uiColor: UIColor {
        return UIColor(cgColor: internalColor)
    }
    
    public var cgColor: CGColor {
        return self.internalColor
    }
    
    public var description: String {
        return self.uiColor.description
    }
    
    public var components: [CGFloat] {
        get {
            guard let components = self.internalColor.components else {
                // TODO: Use Logger
                print("[C4rk] Unexpected `components` value.")
                return UIColor.invalid.cgColor.components!
            }
            return [
                components[0],
                components[1],
                components[2],
                components[3]
            ]
        }
        set {
            let components = [
                newValue[0],
                newValue[1],
                newValue[2],
                newValue[3]
            ]
            self.internalColor = CGColor(colorSpace: self.colorSpace, components: components)!
        }
    }
    
    public var red: CGFloat {
        get {
            return self.components[0]
        }
        set {
            guard RGBValue.contains(newValue) else {
                // TODO: Use Logger
                print("[C4rk] Invalid value \(newValue) for `red`.")
                return
            }
            self.components[0] = newValue
        }
    }
    
    public var green: CGFloat {
        get {
            return self.components[1]
        }
        set {
            guard RGBValue.contains(newValue) else {
                // TODO: Use Logger
                print("[C4rk] Invalid value \(newValue) for `green`.")
                return
            }
            self.components[1] = newValue
        }
    }
    
    public var blue: CGFloat {
        get {
            return self.components[2]
        }
        set {
            guard RGBValue.contains(newValue) else {
                // TODO: Use Logger
                print("[C4rk] Invalid value \(newValue) for `blue`.")
                return
            }
            self.components[2] = newValue
        }
    }
    
    public var alpha: CGFloat {
        get {
            return self.components[3]
        }
        set {
            guard AlphaValue.contains(newValue) else {
                // TODO: Use Logger
                print("[C4rk] Invalid value \(newValue) for `alpha`.")
                return
            }
            self.components[3] = newValue
        }
    }
    
    public var hue: Double {
        let min = min(self.red, self.green, self.blue)
        let max = max(self.red, self.green, self.blue)
        
        if min == max {
            return 0.0
        } else {
            let d = self.red == min
            ? self.green - self.blue
            : ( self.blue == min
                ? self.red - self.green
                : self.blue - self.red)
            let h = self.red == min ? 3.0 : (self.blue == min ? 1.0 : 5.0)
            return (h - d / (max - min)) / 6.0
        }
    }

    public var saturation: Double {
        let min = min(self.red, self.green, self.blue)
        let max = max(self.red, self.green, self.blue)
        return (max - min) / max
    }
    
    public var brightness: Double {
        return max(self.red, self.green, self.blue)
    }
    
    // MARK: Private properties
    
    private var colorSpace: CGColorSpace
    private var internalColor: CGColor
    
    // MARK: - Init/Deinit
    
    public convenience init?() {
        self.init(red: 0, green: 0, blue: 0)
    }
    
    public convenience init?(red: Int, green: Int, blue: Int, alpha: Double) {
        let r = CGFloat(red)
        let g = CGFloat(green)
        let b = CGFloat(blue)
        
        guard [r, g, b].allSatisfy(RGBValue.contains) && AlphaValue.contains(alpha) else {
            // TODO: Use Logger
            print("[C4rk] Invalid values when initializing `Color`.")
            return nil
        }

        self.init(red: r / RGBValue.upperBound,
                  green: g / RGBValue.upperBound,
                  blue: b / RGBValue.upperBound,
                  alpha: alpha)
    }
    
    public convenience init?(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        let validRGB: Bool = [red, green, blue]
            .map { CGFloat($0) }
            .allSatisfy(ClosedRange<CGFloat>.betweenOneAndZero().contains)
        
        guard validRGB && AlphaValue.contains(alpha) else {
            // TODO: Use Logger
            print("[C4rk] Invalid values when initializing `Color`.")
            return nil
        }
        
        self.init(components: [CGFloat(red), CGFloat(green), CGFloat(blue), CGFloat(alpha)])
    }
    
    public convenience init?(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        guard ([hue, saturation, brightness].allSatisfy(HSBValue.contains))
                && AlphaValue.contains(alpha) else {
            // TODO: Use Logger
            print("[C4rk] Invalid values when initializing `Color`.")
            return nil
        }
        self.init(uiColor: UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    public convenience init(_ pattern: String) {
        self.init(uiColor: UIColor(patternImage: UIImage(named: pattern)!))
    }
    
    public convenience init(_ patternImage: LegacyImage) {
        self.init(uiColor: UIColor(patternImage: patternImage.uiimage))
    }
    
    public convenience init(uiColor: UIColor) {
        self.init(cgColor: uiColor.cgColor)
    }
    
    public convenience init?(components: [CGFloat]) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let cgColor = CGColor(colorSpace: colorSpace, components: components) else {
            return nil
        }
        self.init(cgColor: cgColor)
    }
    
    public init(cgColor: CGColor) {
        self.colorSpace = CGColorSpaceCreateDeviceRGB()
        self.internalColor = cgColor
    }
    
}

// MARK: - Protocol conformance

// MARK: Equatable

extension Color {
    
    public static func ==(lhs: Color, rhs: Color) -> Bool {
        return lhs.isEqual(to: rhs)
    }
    
}
