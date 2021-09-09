//
//  Legend.swift
//  SwiftUICharts
//
//  Created by Ray Wojciechowski on 01.09.21.
//

import Foundation
import SwiftUI

/// The type that describes the group of data points in the chart.
public struct Legend: Identifiable {
  public let id = UUID()
  
  /// Color representing the legend
  let color: Color
  
  /// Foreground color to be used for the legend
  let foregroundColor: Color
  
  /// Localized string key representing the legend
  let label: LocalizedStringKey
  
  /// Integer representing the value to sort the array of legends
  let order: Int
  
  /**
   Creates new legend with the following parameters.
   
   - Parameters:
   - color: The color of the group that will be used to draw data points.
   - foregroundColor: The foreground color that will be used to draw data points.
   - label: LocalizedStringKey that describes the legend.
   - order: The number that will be used to sort chart legends list. Default value is 0.
   */
  public init(color: Color,
              foregroundColor: Color = .primary,
              label: LocalizedStringKey,
              order: Int = 0) {
    self.color = color
    self.foregroundColor = foregroundColor
    self.label = label
    self.order = order
  }
}

extension Legend: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.order < rhs.order
  }
}

extension Legend: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
