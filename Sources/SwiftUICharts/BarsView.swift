//
//  BarsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/28/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
//  RayWo, 29.08.2021
//
import SwiftUI

struct BarsView<Delegate: BarChartDelegate>: View {
  let dataPoints: [DataPoint<Delegate.BaseData>]
  let limit: DataPoint<Delegate.BaseData>?
  let style: BarChartStyle
  let maxValue: Double
  let maxLabelValue: Double
  let delegate: Delegate?
  
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottomLeading) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .bottom, spacing: barSpacing) {
            ForEach(dataPoints.filter(\.visible).indexed(),
                    id: \.0.self) { index, bar in
              barView(for: bar, index: index, in: geometry)
            }
          }
          .frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
          .padding(.top)
          
          if style.gridStyle.showLabels {
            HStack(spacing: barSpacing) {
              ForEach(dataPoints.filter(\.visible).indexed(),
                      id: \.0.self) { index, bar in
                if let everyNthLabel = style.gridStyle.everyNthLabel {
                  if index % everyNthLabel == 0 {
                    Text(bar.label)
                      .foregroundColor(.accentColor)
                      .frame(maxWidth: maxLabelWidth, alignment: .bottomLeading)
                      .padding(.horizontal, 2)
                  }
                } else {
                  Text(bar.label)
                    .foregroundColor(.accentColor)
                    .frame(maxWidth: maxLabelWidth, alignment: .center)
                }
              }
            }
            .frame(height: style.gridStyle.labelHeight)
          }
        }
        
        limit.map { limit in
          limitView(for: limit, in: geometry)
        }
      }
    }
  }
  
  private var barSpacing: CGFloat {
    dataPoints.count > 40 ? 0 : 5
  }
  
  private var maxLabelWidth: CGFloat {
    var result = style.barMaxWidth
    
    if let everyNthLabel = style.gridStyle.everyNthLabel {
      result = style.barMaxWidth * CGFloat(everyNthLabel)
    }
    
    return result
  }
  
  private func offsetToMax(in rect: CGRect) -> CGFloat {
    (maxLabelValue - maxValue) * rect.size.height / maxValue
  }
  
  private func fullHeight(in rect: CGRect) -> CGFloat {
    CGFloat(rect.size.height + cutForLabels - offsetToMax(in: rect))
  }
  
  private var cutForLabels: CGFloat {
    style.gridStyle.showLabels ? 0 : style.gridStyle.labelHeight
  }
  
  private func barView(for point: DataPoint<Delegate.BaseData>,
                       index: Int,
                       in geometry: GeometryProxy) -> some View {
    let startY = -CGFloat(point.startValue / maxValue) * geometry.size.height
    let fullHeight = fullHeight(in: geometry.frame(in: .local))
    let barHeight = (point.endValue - point.startValue) / maxValue * fullHeight
    
    return ZStack(alignment: .bottom) {
      if style.showShadowBar {
        Capsule(style: .continuous)
          .fill(.gray.opacity(0.2))
          .accessibilityHidden(true)
          .offset(y: 0)
          .frame(height: fullHeight)
          .frame(maxWidth: style.barMaxWidth)
      }
      
      Capsule(style: .continuous)
        .fill(point.legend.color)
        .accessibilityLabel(Text(point.label))
        .accessibilityValue(Text(point.legend.label))
        .offset(y: startY)
        .frame(height: barHeight)
        .frame(maxWidth: style.barMaxWidth)
      
      // TODO Make as option. Take bar width into account for font size.
//      Text(formatter.string(from: NSNumber(value: point.endValue)) ?? "")
//        .font(.system(size: 13))
//        .padding(0)
//        .rotationEffect(Angle(degrees: -90))
//        .offset(y: -20)
//        .frame(maxHeight: style.barMaxWidth)
    }
    .onTapGesture {
      delegate?.barChart(didSelectBar: point)
    }
  }
  
  private func limitView(for limit: DataPoint<Delegate.BaseData>,
                         in geometry: GeometryProxy) -> some View {
    let lineHeight = CGFloat(2)
    let labelMaxHeight = CGFloat(25)
    let offsetForLabels = style.gridStyle.showLabels ? 0 : style.gridStyle.labelHeight
    
    let fullHeight = fullHeight(in: geometry.frame(in: .local))
    let limitHeight = limit.endValue / maxValue * fullHeight
    let y = -labelMaxHeight/2 - limitHeight + offsetForLabels + lineHeight*2
    
    return ZStack {
      RoundedRectangle(cornerRadius: lineHeight)
        .frame(height: lineHeight)
        .foregroundColor(limit.legend.color)
      Text(limit.label)
        .font(.system(size: 17))
        .frame(height: labelMaxHeight)
        .padding(.horizontal)
        .foregroundColor(limit.legend.foregroundColor)
        .background(limit.legend.color)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
    .offset(y: y)
  }
  
  private var formatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 1
    
    return formatter
  }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
  static var gridStyle = GridStyle(showLabels: true,
                                   everyNthLabel: nil,
                                   labelHeight: 22,
                                   showAxis: true,
                                   axisLeadingPadding: 5,
                                   gridLines: 10,
                                   roundToNearest: 5)
  
  static var style = BarChartStyle(barMinHeight: 300,
                                   barMaxWidth: 22,
                                   showLegends: true,
                                   showShadowBar: true,
                                   usesInfoArea: true,
                                   infoAreaHeight: 150,
                                   gridStyle: gridStyle)
  
  static var gridStyle2 = GridStyle(showLabels: true,
                                    everyNthLabel: 5,
                                    labelHeight: 22,
                                    showAxis: true,
                                    axisLeadingPadding: 5,
                                    gridLines: 6,
                                    roundToNearest: 5)
  
  static var style2 = BarChartStyle(barMinHeight: 100,
                                    barMaxWidth: 22,
                                    showLegends: true,
                                    showShadowBar: true,
                                    usesInfoArea: true,
                                    infoAreaHeight: 150,
                                    gridStyle: gridStyle2)
  
  
  static var fewDataPoints = DataPoint<Int>.mock
  
  static var maxValueFew: Double {
    guard let max = fewDataPoints.max() else { return 0.0 }
    
    return max.endValue
  }
  static var maxLabelValueFew: Double {
    round(maxValueFew + maxValueFew * 0.15, toNearest: Double(2))
  }
  
  static var manyDataPoints = DataPoint<Int>.mock
  
  static var maxValueMany: Double {
    guard let max = manyDataPoints.max() else { return 0.0 }
    
    return max.endValue
  }
  static var maxLabelValueMany: Double {
    round(maxValueMany + maxValueMany * 0.15, toNearest: Double(2))
  }
  
  static var singleDataPoint = DataPoint<Int>(value: 109,
                                              label: "avg: 109",
                                              legend: Legend(color: .red,
                                                             label: "avg"))
  
  static var grid: some View {
    ChartGridView(gridLines: style.gridStyle.gridLines,
                  showLabels: style.gridStyle.showLabels,
                  labelsHeight: style.gridStyle.labelHeight)
  }
  
  static var previews: some View {
    Form {
      Section(header: Text("single value")) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(spacing: 0) {
            BarsView(dataPoints: [singleDataPoint],
                     limit: singleDataPoint,
                     style: style,
                     maxValue: 109,
                     maxLabelValue: 120,
                     delegate: DefaultBarChartDelegate())
              .frame(minHeight: style.barMinHeight)
              .background(grid)
            
            if style.gridStyle.showAxis {
              AxisView(dataPoints: [singleDataPoint],
                       gridLines: style.gridStyle.gridLines,
                       roundTo: 5, //style.gridStyle.roundToNearest,
                       showLabels: style.gridStyle.showLabels,
                       labelsHeight: style.gridStyle.labelHeight,
                       maxValue: 109,
                       maxLabelValue: 120,
                       step: 15)
              //                .fixedSize(horizontal: true, vertical: false)
                .frame(minHeight: style.barMinHeight)
                .accessibilityHidden(true)
                .padding(.leading, style.gridStyle.axisLeadingPadding)
            }
          }
          .padding(.top)
          
          if style.showLegends {
            LegendView(dataPoints: [singleDataPoint])
              .padding()
              .accessibilityHidden(true)
          }
        }
      }
      
      Section(header: Text("single value")) {
        Text("hello")
      }
    }
    
    
    BarsView<DefaultBarChartDelegate>(dataPoints: DataPoint.mockFewData,
                                      limit: DataPoint.mockLimit,
                                      style: style,
                                      maxValue: maxValueFew,
                                      maxLabelValue: maxLabelValueFew,
                                      delegate: nil)
    
    BarsView<DefaultBarChartDelegate>(dataPoints: manyDataPoints,
                                      limit: nil,
                                      style: style2,
                                      maxValue: maxValueMany,
                                      maxLabelValue: maxLabelValueMany,
                                      delegate: nil)
  }
}
#endif
