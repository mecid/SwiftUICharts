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
  
  
  /// Creates new bar chart view with the following parameters.
  /// - Parameters:
  ///   - dataPoints: The array of data points that will be used to draw
  ///                 the bar chart.
  ///   - limit: The horizontal line that will be drawn over bars.
  ///            Default is nil.
  public init(dataPoints: [DataPoint], limit: DataPoint? = nil) {
    self.dataPoints = dataPoints
    self.limit = limit
  }
  
  private var style: BarChartStyle {
    (chartStyle as? BarChartStyle) ?? .init()
  }
  
  private var grid: some View {
    ChartGridView(gridLines: style.gridStyle.gridLines,
                  showLabels: style.gridStyle.showLabels,
                  labelsHeight: style.gridStyle.labelHeight)
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      VStack {
        HStack(spacing: 0) {
          BarsView(dataPoints: dataPoints,
                   limit: limit,
                   style: style)
            .frame(minHeight: style.barMinHeight)
            .background(grid)
          
          if style.gridStyle.showAxis {
            AxisView(dataPoints: dataPoints,
                     gridLines: style.gridStyle.gridLines,
                     showLabels: style.gridStyle.showLabels,
                     labelsHeight: style.gridStyle.labelHeight,
                     toNearest: style.gridStyle.roundToNearest)
              .fixedSize(horizontal: true, vertical: false)
              .accessibilityHidden(true)
              .padding(.leading, style.gridStyle.axisLeadingPadding)
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
  
  static let limitBar = DataPoint(value: 52, label: "Trend", legend: limit)
  
  static let gridStyle = GridStyle(showLabels: false,
                                   everyNthLabel: nil,
                                   showAxis: true,
                                   axisLeadingPadding: 5,
                                   gridLines: 5,
                                   roundToNearest: 10)
  
  static let style = BarChartStyle(barMinHeight: 200.0,
                                   showLegends: false,
                                   showShadowBar: false,
                                   gridStyle: gridStyle)
  
  static let gridStyle2 = GridStyle(showLabels: true,
                                    everyNthLabel: 5,
                                    showAxis: true,
                                    axisLeadingPadding: 5,
                                    gridLines: 10,
                                    roundToNearest: 10)
  
  static let style2 = BarChartStyle(barMinHeight: 200.0,
                                    showLegends: false,
                                    showShadowBar: true,
                                    gridStyle: gridStyle2)
  
  
  static var previews: some View {
    Form {
      Section(header: Text("charts")) {
        HStack(spacing: 0) {
          BarChartView(dataPoints: DataPoint.mockFewData, limit: limitBar)
//          BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
        }
        .chartStyle(style)
      }
      
      Section(header: Text("charts")) {
        HStack(spacing: 0) {
//          BarChartView(dataPoints: DataPoint.mockFewData, limit: limitBar)
          BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
        }
        .chartStyle(style2)
      }
    }
  }
}
#endif
