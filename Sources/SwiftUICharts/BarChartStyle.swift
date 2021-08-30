//
//  File.swift
//  File
//
//  Created by Ray Wojciechowski on 30.08.21.
//

import Foundation
import SwiftUI


/// Type that defines a bar chart style.
public struct BarChartStyle: ChartStyle {
  
  /// Minimal height for a bar chart view
  public let barMinHeight: CGFloat
  
  /// Maximal width for a single Bar in a bar chart
  public let barMaxWidth: CGFloat
  
  /// Boolean value indicating whenever show chart axis
  public let showAxis: Bool
  
  /// Leading padding for the value axis displayed in the chart
  public let axisLeadingPadding: CGFloat
  
  /// Indicating whether to show Labels below the chart
  public let showLabels: Bool
  
  /// Only every nth label is shown below the chart. Nil value shows all the labels.
  public let everyNthLabel: Int?
  
  /// The maximum height a label can use.
  public let labelHeight: CGFloat
  
  public let showLegends: Bool
  
  /// Determines if the bar chart should use an info area above the charts.
  public let usesInfoArea: Bool
  
  /// The height of the info area if one is used.
  public let infoAreaHeight: CGFloat
  
  /// The number of grid lines to be shown (including min and max lines)
  public let gridLines: Int
  
  /**
   Creates new bar chart style with the following parameters.
   
   - Parameters:
   - barMinHeight: The minimal height for the bar that presents the biggest value. Default is 100.
   - barMaxWidth: The maximal width for a bar in the bar chart. Useful when there are only a few data points. Default is 20
   - showAxis: Bool value that controls whenever to show axis.
   - axisLeadingPadding: Leading padding for axis line. Default is 0.
   - showLabels: Bool value that controls whenever to show labels.
   - everyNthLabel: Only every nth label is shown below the chart. Default is all.
   - labelHeight: The maximum height a label can use. Default is 22.
   - showLegends: Bool value that controls whenever to show legends.
   - usesInfoArea: Bool value that controls whether to show an info area above the charts. Useful if more info for a bar should be shown when tapped. Default is false.
   - infoAreaHeight: The height of the info area. Default is 200.
   - gridLines: The number of grid lines to be shown (including min and max lines). Default is 3 (min, middle, max).
   */
  public init(
    barMinHeight: CGFloat = 100,
    barMaxWidth: CGFloat = 20,
    showAxis: Bool = true,
    axisLeadingPadding: CGFloat = 0,
    showLabels: Bool = true,
    everyNthLabel: Int? = nil,
    labelHeight: CGFloat = 22,
    showLegends: Bool = true,
    usesInfoArea: Bool = false,
    infoAreaHeight: CGFloat = 200,
    gridLines: Int = 3
  ) {
    self.barMinHeight = barMinHeight
    self.barMaxWidth = barMaxWidth
    self.showAxis = showAxis
    self.axisLeadingPadding = axisLeadingPadding
    self.showLabels = showLabels
    self.everyNthLabel = everyNthLabel
    self.labelHeight = labelHeight
    self.showLegends = showLegends
    self.usesInfoArea = usesInfoArea
    self.infoAreaHeight = infoAreaHeight
    self.gridLines = gridLines
  }
}
