//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
//  RayWo, 30.08.2021
//
import SwiftUI

/// Type that defines a line chart style.
public struct LineChartStyle: ChartStyle {
  /// Minimal height for a line chart view
  public let lineMinHeight: CGFloat
  
  public let showLabels: Bool
  
  /// Only every nth label is shown below the chart. Nil value shows all the labels.
  public let everyNthLabel: Int?
  
  /// The maximum height a label can use.
  public let labelHeight: CGFloat
  
  public let showLegends: Bool
  
  public let gridStyle: GridStyle
  
  
  /**
   Creates new line chart style with the following parameters.
   
   - Parameters:
   - lineMinHeight: The minimal height for the point that presents the biggest value. Default is 100.
   - showAxis: Bool value that controls whenever to show axis.
   - axisLeadingPadding: Leading padding for axis line. Default is 0.
   - showLabels: Bool value that controls whenever to show labels.
   - everyNthLabel: Only every nth label is shown below the chart. Default is all.
   - labelHeight: The maximum height a label can use. Default is 22.   
   - labelCount: The count of labels that should be shown below the the chart. Default is all.
   - showLegends: Bool value that controls whenever to show legends.
   - gridLines: The number of grid lines to be shown (including min and max lines). Default is 3 (min, middle, max).   
   */
  
  public init(
    lineMinHeight: CGFloat = 100,
    showLabels: Bool = true,
    everyNthLabel: Int? = nil,
    labelHeight: CGFloat = 22,
    labelCount: Int? = nil,
    showLegends: Bool = true,
    gridStyle: GridStyle = GridStyle()
  ) {
    self.lineMinHeight = lineMinHeight
    self.showLabels = showLabels
    self.everyNthLabel = everyNthLabel
    self.labelHeight = labelHeight
    self.showLegends = showLegends
    self.gridStyle = gridStyle
  }
}

/// SwiftUI view that draws data points by drawing a line.
public struct LineChartView: View {
  @Environment(\.chartStyle) var chartStyle
  let dataPoints: [DataPoint]
  
  /**
   Creates new line chart view with the following parameters.
   
   - Parameters:
   - dataPoints: The array of data points that will be used to draw the bar chart.
   */
  public init(dataPoints: [DataPoint]) {
    self.dataPoints = dataPoints
  }
  
  private var style: LineChartStyle {
    (chartStyle as? LineChartStyle) ?? .init()
  }
  
  private var gradient: LinearGradient {
    let colors = dataPoints.map(\.legend).map(\.color)
    return LinearGradient(
      gradient: Gradient(colors: colors),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
  
  private var grid: some View {
    ChartGridView(gridLines: 4,
                  showLabels: style.showLabels,
                  labelsHeight: style.labelHeight)
  }
  
  public var body: some View {
    VStack {
      HStack(spacing: 0) {
        LineChartShape(dataPoints: dataPoints)
          .fill(gradient)
          .frame(minHeight: style.lineMinHeight)
          .background(grid)
        
        if style.gridStyle.showAxis {
          AxisView(dataPoints: dataPoints,
                   gridLines: style.gridStyle.gridLines,
                   showLabels: style.showLabels,
                   labelsHeight: style.labelHeight,
                   toNearest: style.gridStyle.roundToNearest)
            .accessibilityHidden(true)
            .padding(.leading, style.gridStyle.axisLeadingPadding)
        }
      }
      
      if style.showLabels {
        LabelsView(dataPoints: dataPoints, everyNthLabel: style.everyNthLabel ?? dataPoints.count)
          .accessibilityHidden(true)
      }
      
      if style.showLegends {
        LegendView(dataPoints: dataPoints)
          .padding()
          .accessibilityHidden(true)
      }
    }
  }
}

#if DEBUG
struct LineChartView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      LineChartView(dataPoints: DataPoint.mock)
      LineChartView(dataPoints: DataPoint.mock)
    }.chartStyle(LineChartStyle(showLabels: false))
  }
}
#endif
