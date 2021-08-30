//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
//  RayWo, 29.08.2021
//
import SwiftUI


/// SwiftUI view that draws bars by placing them into a horizontal container.
public struct BarChartView: View {
  @Environment(\.chartStyle) var chartStyle
  
  let dataPoints: [DataPoint]
  let limit: DataPoint?
  
  /**
   Creates new bar chart view with the following parameters.
   
   - Parameters:
   - dataPoints: The array of data points that will be used to draw the bar chart.
   - limit: The horizontal line that will be drawn over bars. Default is nil.
   */
  public init(dataPoints: [DataPoint], limit: DataPoint? = nil) {
    self.dataPoints = dataPoints
    self.limit = limit
  }
  
  private var style: BarChartStyle {
    (chartStyle as? BarChartStyle) ?? .init()
  }
  
  private var grid: some View {
    ChartGridView(gridLines: style.gridLines,
                  showLabels: style.showLabels,
                  labelsHeight: style.labelHeight)
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack {
        HStack(spacing: 0) {
          BarsView(dataPoints: dataPoints,
                   limit: limit,
                   showAxis: style.showAxis,
                   showLabels: style.showLabels,
                   everyNthLabel: style.everyNthLabel,
                   labelHeight: style.labelHeight,
                   maxBarWidth: style.barMaxWidth)
            .frame(minHeight: style.barMinHeight)
            .background(grid)
          
          if style.showAxis {
            AxisView(dataPoints: dataPoints,
                     gridLines: style.gridLines,
                     showLabels: style.showLabels,
                     labelsHeight: style.labelHeight)
              .fixedSize(horizontal: true, vertical: false)
              .accessibilityHidden(true)
              .padding(.leading, style.axisLeadingPadding)
          }
        }
        .padding(.top)
      }
      
      if style.showLegends {
        LegendView(dataPoints: limit.map { [$0] + dataPoints} ?? dataPoints)
          .padding()
          .accessibilityHidden(true)
      }
    }
  }
}

#if DEBUG
struct BarChartView_Previews : PreviewProvider {
  static let limit = Legend(color: .purple, label: "Trend")
  
  static let limitBar = DataPoint(value: 100, label: "Trend", legend: limit)
  
  static let style = BarChartStyle(barMinHeight: 200.0,
                                   axisLeadingPadding: 5,
                                   showLabels: true,
                                   everyNthLabel: 5,
                                   showLegends: false,
                                   gridLines: 5)
  
  
  static var previews: some View {
    Form {
      Section(header: Text("charts")) {
        HStack(spacing: 0) {
          BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
//          BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
        }
        .chartStyle(style)
      }
    }
  }
}
#endif
