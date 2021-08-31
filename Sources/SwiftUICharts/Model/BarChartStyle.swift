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
  
  /// Controls whether a legend is shown or not
  public let showLegends: Bool
  
  public let showShadowBar: Bool
  
  /// Determines if the bar chart should use an info area above the charts.
  public let usesInfoArea: Bool
  
  /// The height of the info area if one is used.
  public let infoAreaHeight: CGFloat
  
  /// The style to be used for drawing the chart’s grid. Default is the
  /// default grid style.
  public let gridStyle: GridStyle

  
  /// Creates new bar chart style with the following parameters.
  /// - Parameters:
  ///   - barMinHeight: The minimal height for the bar that presents the
  ///                   biggest value. Default is 100.
  ///   - barMaxWidth: The maximal width for a bar in the bar chart. Useful
  ///                  when there are only a few data points. Default is 20.
  ///   - showLegends: Bool value that controls whenever to show legends.
  ///   - showShadowBar: Bool value that controls whether to show a dimmed out
  ///                    full length bar behind the actual bar. Default is true.
  ///   - usesInfoArea: Bool value that controls whether to show an info area
  ///                   above the charts. Useful if more info for a bar should
  ///                   be shown when tapped. Default is false.
  ///   - infoAreaHeight: The height of the info area. Default is 200.
  ///   - gridStyle: The style to be used for drawing the chart’s grid.
  ///                Default is the default grid style.
  public init(barMinHeight: CGFloat = 100,
              barMaxWidth: CGFloat = 20,
              showLegends: Bool = true,
              showShadowBar: Bool = true,
              usesInfoArea: Bool = false,
              infoAreaHeight: CGFloat = 200,
              gridStyle: GridStyle = GridStyle()) {
    self.barMinHeight = barMinHeight
    self.barMaxWidth = barMaxWidth
    self.showLegends = showLegends
    self.showShadowBar = showShadowBar
    self.usesInfoArea = usesInfoArea
    self.infoAreaHeight = infoAreaHeight
    self.gridStyle = gridStyle
  }
}
