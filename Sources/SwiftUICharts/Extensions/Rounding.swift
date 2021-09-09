//
//  Rounding.swift
//  SwiftUICharts
//
//  Created by Ray Wojciechowski on 30.08.21.
//

import Foundation

/// Round the given value to the nearest multiple of `toNearest`.
/// Parameters:
///   - value: The value to round
///   - toNearest: The factor to round to
public func round(_ value: Double, toNearest: Double) -> Double {
  round(value / toNearest) * toNearest
}

/// Round down the given value to the nearest multiple of `toNearest`.
/// Parameters:
///   - value: The value to round
///   - toNearest: The factor to round to
public func floor(_ value: Double, toNearest: Double) -> Double {
  floor(value / toNearest) * toNearest
}

/// Round up the given value to the nearest multiple of `toNearest`.
/// Parameters:
///   - value: The value to round
///   - toNearest: The factor to round to
public func ceil(_ value: Double, toNearest: Double) -> Double {
  ceil(value / toNearest) * toNearest
}
