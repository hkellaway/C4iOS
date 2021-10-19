//
//
//  ColorConvertible.swift
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

public protocol ColorConvertible {
    /// Color cast to `UIColor`.
    var uiColor: UIColor { get }
    
    /// Whether this color is equal to another.
    ///
    /// - Parameter other: Color to compare to.
    ///
    /// - Returns: True if equal, false otherwise.
    func isEqual(to other: ColorConvertible) -> Bool
}

extension ColorConvertible {
    
    /// Color cast to `CGColor`.
    public var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    /// Color cast to `CIColor`.
    public var ciColor: CIColor {
        return uiColor.ciColor
    }
    
}

// MARK: - Equality

extension ColorConvertible {
    
    public func isEqual(to other: ColorConvertible) -> Bool {
        return self.cgColor.components == other.cgColor.components
    }
    
}

// MARK: - Core type exetensions

extension Array where Element == ColorConvertible {

    public func isEqual(to other: [ColorConvertible]) -> Bool {
        return zip(self, other).reduce(true) { (runningValue, colors) in
            let (c1, c2) = colors
            return runningValue && (type(of: c1) == type(of: c2) && c1.isEqual(to: c2))
        }
    }

}

extension UIColor: ColorConvertible {
    
    public var uiColor: UIColor {
        return self
    }
    
}
