//
//  GridStyle.swift
//  SwiftUICharts
//
//  Created by Ray Wojciechowski on 30.08.21.
//

import Foundation
import SwiftUI

public struct GridStyle {
  /// Indicating whether to show Labels below the chart
  public let showLabels: Bool
  
  /// Only every nth label is shown below the chart. Nil value shows all
  /// the labels.
  public let everyNthLabel: Int?
  
  /// The maximum height a label can use.
  public let labelHeight: CGFloat
  
  /// Boolean value indicating whenever show chart axis
  public let showAxis: Bool
  
  /// Leading padding for the value axis displayed in the chart
  public let axisLeadingPadding: CGFloat
  
  /// The number of grid lines to be shown (not counting the zero line)
  public let gridLines: Int
  
  /// The value to which the axis labels should be rounded to
  public let roundToNearest: Double
 
  
  /// Creates a new grid style with the following parameters.
  ///
  /// - Parameters:
  ///   - showLabels: Bool value that indicates whether to show labels.
  ///                 Default is true.
  ///   - everyNthLabel: Only every nth label is shown below the chart.
  ///                    Default is all.
  ///   - labelHeight: The maximum height a label can use. Default is 22.
  ///   - showAxis: Bool value that controls whether to show axis.
  ///               Default is true.
  ///   - axisLeadingPadding: Leading padding for axis line. Default is 0.
  ///   - gridLines: The number of grid lines to be shown (including min and
  ///                max lines). Default is 4.
  ///   - roundToNearest: The value to which the axis labels should be
  ///                     rounded to. Default is 5.
  public init(showLabels: Bool = true,
              everyNthLabel: Int? = nil,
              labelHeight: CGFloat = 22,
              showAxis: Bool = true,
              axisLeadingPadding: CGFloat = 0,
              gridLines: Int = 4,
              roundToNearest: Double = 5) {
    self.showLabels = showLabels
    self.everyNthLabel = everyNthLabel
    self.labelHeight = labelHeight
    self.showAxis = showAxis
    self.axisLeadingPadding = axisLeadingPadding
    self.gridLines = gridLines
    self.roundToNearest = roundToNearest
  }
}
