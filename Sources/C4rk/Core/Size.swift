//
//
//  Size.swift
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

/// A structure that contains width and height values. Values stored as Double, otherwise synonymous with CGSize.
public struct Size: Comparable, CustomStringConvertible, Equatable {
    
    // MARK: - Properties
    
    ///The width of the size.
    public var width: Double

    ///The height of the size.
    public var height: Double
    
    /// Size case to `CGSize`.
    public var cgSize: CGSize {
        return CGSize(width: CGFloat(self.width), height: CGFloat(self.height))
    }
    
    /// A string representation of the size.
    ///
    /// - returns: A string formatted to look like {w,h}
    public var description: String {
        return "{\(width),\(height)}"
    }
    
    // MARK: - Init/Deinit
    
    /// Size with width and height of 0.
    public static let zero = Size(0, 0)

    /// Initializes a new Size with the dimensions {width,height}
    ///
    /// ````
    /// let s = Size(5.2,5.2)
    /// ````
    public init(_ width: Double, _ height: Double) {
        self.width = width
        self.height = height
    }

    /// Initializes a new Size with the dimensions {width,height}, converting Int values to Double
    ///
    /// ````
    /// let s = Size(5,5)
    /// ````
    public init(_ width: Int, _ height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }

    /// Initializes a new Size from a CGSize.
    ///
    public init(_ size: CGSize) {
        self.width = Double(size.width)
        self.height = Double(size.height)
    }
    
    // MARK: - Instance functions
    
    /// Area of the size (width * height).
    ///
    /// - Returns: Area if width and height are non-negative, nil otherwise.
    ///
    public func area() -> Double? {
        guard self.width >= 0 && self.height >= 0 else {
            return nil
        }
        return self.width * self.height
    }
    
}

// MARK: - Protocol conformance

// MARK: Comparable

extension Size {
    
    /// Returns true if the left-hand Size is smaller than the right-hand area.
    ///
    /// ````
    /// let s1 = Size(3,4)
    /// let s2 = Size(4,3)
    /// let s3 = Size(2,2)
    ///
    /// s1 < s2 //-> false
    /// s2 < s3 //-> false
    /// ````
    /// - parameter lhs: The first size to compare
    /// - parameter rhs: The second size to compare
    /// - returns: A boolean, `true` if the area of lhs is less than that of rhs
    public static func < (lhs: Size, rhs: Size) -> Bool {
        return (lhs.width * lhs.height) < (rhs.width * rhs.height)
    }

}

// MARK: Equatable

extension Size {
    
    /// Returns true if the two Sizes share identical dimensions.
    ///
    /// ````
    /// let s1 = Size()
    /// let s2 = Size(1,1)
    /// s1 == s2 //-> false
    /// ````
    /// - parameter lhs: The first size to compare
    /// - parameter rhs: The second size to compare
    /// - returns: True if the sizes are equal, false otherwise.
    public static func == (lhs: Size, rhs: Size) -> Bool {
        return (lhs.width == rhs.width) && (lhs.height == rhs.height)
    }
    
}
