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
  let delegate: Delegate?
  
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottomLeading) {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .bottom, spacing: barSpacing) {
            ForEach(dataPoints.filter(\.visible).indexed(),
                    id: \.1.self) { index, bar in
              barView(for: bar, index: index, in: geometry)
            }
          }
          .frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
          .padding(.top)
          
          if style.gridStyle.showLabels {
            HStack(spacing: barSpacing) {
              ForEach(dataPoints.filter(\.visible).indexed(),
                      id: \.1.self) { index, bar in
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
  
  private var max: Double {
    guard let max = dataPoints.max()?.endValue, max != 0 else {
      return 1
    }
    return max
  }
  
  private var maxAxisLabelValue: Double {
    round(max + max * 0.15, toNearest: 5)
  }
  
  private func barView(for point: DataPoint<Delegate.BaseData>,
                       index: Int,
                       in geometry: GeometryProxy) -> some View {
    let topCut = style.gridStyle.showLabels ? style.gridStyle.labelHeight : 0
    let y = -CGFloat(point.startValue / max) * geometry.size.height
    
    return ZStack(alignment: .bottom) {
      if style.showShadowBar {
        Capsule(style: .continuous)
          .fill(.gray.opacity(0.2))
          .accessibilityHidden(true)
          .offset(y: y)
          .frame(height: CGFloat(geometry.size.height - topCut - offsetToMax))
          .frame(maxWidth: style.barMaxWidth)
      }
      
      Capsule(style: .continuous)
        .fill(point.legend.color)
        .accessibilityLabel(Text(point.label))
        .accessibilityValue(Text(point.legend.label))
        .offset(y: y)
        .frame(height: CGFloat((point.endValue-point.startValue) / max) * (geometry.size.height - topCut - offsetToMax))
        .frame(maxWidth: style.barMaxWidth)
    }
    .onTapGesture {
      delegate?.barChart(didSelectBar: point)
    }
  }
  
  private var offsetToMax: CGFloat {
    maxAxisLabelValue - max
  }
  
  private func limitView(for limit: DataPoint<Delegate.BaseData>,
                         in geometry: GeometryProxy) -> some View {
    let lineHeight = CGFloat(2)
    let y = -CGFloat(limit.endValue / self.maxAxisLabelValue) * (geometry.size.height - lineHeight/2)
    
    return ZStack {
      RoundedRectangle(cornerRadius: lineHeight)
        .frame(height: lineHeight)
        .foregroundColor(limit.legend.color)
      Text(limit.label)
        .font(.callout)
        .padding(.horizontal)
        .foregroundColor(limit.legend.foregroundColor)
        .background(limit.legend.color)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
    .offset(y: y)
  }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
  static var gridStyle = GridStyle(showLabels: true,
                                   everyNthLabel: nil,
                                   labelHeight: 22,
                                   showAxis: true,
                                   axisLeadingPadding: 5,
                                   gridLines: 6,
                                   roundToNearest: 5)
  
  static var style = BarChartStyle(barMinHeight: 100,
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
  
  static var previews: some View {
    BarsView<DefaultBarChartDelegate>(dataPoints: DataPoint.mockFewData,
                  limit: DataPoint.mockLimit,
                  style: style,
                  delegate: nil)
    
    BarsView<DefaultBarChartDelegate>(dataPoints: DataPoint.mock,
                  limit: nil,
                  style: style2,
                  delegate: nil)
  }
}
#endif
