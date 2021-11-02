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
public struct BarChartView<Delegate: BarChartDelegate>: View {
//  @Environment(\.chartStyle) var chartStyle
  
  let dataPoints: [DataPoint<Delegate.BaseData>]
  let limit: DataPoint<Delegate.BaseData>?
  let delegate: Delegate?
  let style: BarChartStyle
  
  
  /// Creates new bar chart view with the following parameters.
  /// - Parameters:
  ///   - dataPoints: The array of data points that will be used to draw
  ///                 the bar chart.
  ///   - limit: The horizontal line that will be drawn over bars.
  ///            Default is nil.
  public init(dataPoints: [DataPoint<Delegate.BaseData>],
              limit: DataPoint<Delegate.BaseData>? = nil,
              delegate: Delegate? = nil,
              style: BarChartStyle) {
    self.dataPoints = dataPoints
    self.limit = limit
    self.delegate = delegate
    self.style = style
  }
  
//  private var style: BarChartStyle {
//    (chartStyle as? BarChartStyle) ?? .init()
//  }
  
  private var grid: some View {
    ChartGridView(gridLines: style.gridStyle.gridLines,
                  showLabels: style.gridStyle.showLabels,
                  labelsHeight: style.gridStyle.labelHeight)
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 0) {
        BarsView(dataPoints: dataPoints,
                 limit: limit,
                 style: style,
                 maxValue: maxValue,
                 maxLabelValue: stepAndMaxAxisLabelValue.value,
                 delegate: delegate)
          .frame(minHeight: style.barMinHeight)
          .background(grid)
        
        if style.gridStyle.showAxis {
          AxisView(dataPoints: dataPoints,
                   gridLines: style.gridStyle.gridLines,
                   roundTo: style.gridStyle.roundToNearest,
                   showLabels: style.gridStyle.showLabels,
                   labelsHeight: style.gridStyle.labelHeight,
                   maxValue: maxValue,
                   maxLabelValue: stepAndMaxAxisLabelValue.value,
                   step: stepAndMaxAxisLabelValue.step)
          //                .fixedSize(horizontal: true, vertical: false)
            .frame(minHeight: style.barMinHeight)
            .accessibilityHidden(true)
            .padding(.leading, style.gridStyle.axisLeadingPadding)
        }
      }
      .padding(.top)
      
      if style.showLegends {
        LegendView(dataPoints: limit.map { [$0] + dataPoints} ?? dataPoints)
          .padding()
          .accessibilityHidden(true)
      }
    }
  }
  
  private var maxValue: Double {
    guard let max = dataPoints.max()?.endValue, max != 0 else {
      return 1
    }
    return max
  }
  
  private var stepAndMaxAxisLabelValue: (step: Double, value: Double) {
    var percentage = 0.05
    let nearest = Double(style.gridStyle.roundToNearest)
    let gridLines = Double(style.gridStyle.gridLines)
    
    if maxValue < 50 {
      percentage = 0.025
    }
    
    let suggested = ceil(maxValue + maxValue * percentage, toNearest: nearest)
    let step = ceil((suggested / (gridLines - 1)), toNearest: nearest/2)
    
    return (step, step * gridLines)
  }
}

#if DEBUG
struct BarChartView_Previews : PreviewProvider {
  static let limit = Legend(color: .purple, label: "Trend")
  
  static let limitBar = DataPoint<Int>(value: 52, label: "Trend", legend: limit)
  
  static let gridStyle = GridStyle(showLabels: false,
                                   everyNthLabel: nil,
                                   showAxis: true,
                                   axisLeadingPadding: 5,
                                   gridLines: 10,
                                   roundToNearest: 5)
  
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
  
  
  static var singleDataPoint = DataPoint<Int>(value: 109,
                                              label: "avg: 109",
                                              legend: Legend(color: .red,
                                                             label: "avg"))
  
  
  static var previews: some View {
    Form {
      Section(header: Text("single value")) {
        BarChartView<DefaultBarChartDelegate>(dataPoints: [singleDataPoint],
                                              limit: singleDataPoint,
                                              style: style)
//          .chartStyle(style)
      }
      
//      Section(header: Text("charts")) {
//        HStack(spacing: 0) {
//          BarChartView<DefaultBarChartDelegate>(dataPoints: DataPoint.mockFewData,
//                                                limit: limitBar,
//                                                style: style)
////          BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
//        }
////        .chartStyle(style)
//      }
//
//      Section(header: Text("charts")) {
//        HStack(spacing: 0) {
////          BarChartView(dataPoints: DataPoint.mockFewData, limit: limitBar)
//          BarChartView<DefaultBarChartDelegate>(dataPoints: DataPoint.mock,
//                                                limit: limitBar,
//                                                style: style2)
//        }
////        .chartStyle(style2)
//      }
    }
  }
}
#endif
