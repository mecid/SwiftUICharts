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

struct BarsView: View {
  let dataPoints: [DataPoint]
  let limit: DataPoint?
  let showAxis: Bool
  let showLabels: Bool
  let everyNthLabel: Int?
  let labelHeight: CGFloat
  let maxBarWidth: CGFloat
  
  
  private var max: Double {
    guard let max = dataPoints.max()?.endValue, max != 0 else {
      return 1
    }
    return max
  }
  
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
          
          if showLabels {
            HStack(spacing: barSpacing) {
              ForEach(dataPoints.filter(\.visible).indexed(),
                      id: \.1.self) { index, bar in
                if let everyNthLabel = everyNthLabel {
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
            .frame(height: labelHeight)
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
    var result = maxBarWidth
    
    if let everyNthLabel = everyNthLabel {
      result = maxBarWidth * CGFloat(everyNthLabel)
    }
    
    return result
  }
  
  private func barView(for point: DataPoint,
                       index: Int,
                       in geometry: GeometryProxy) -> some View {
    let topCut = showLabels ? labelHeight : 0
    let y = -CGFloat(point.startValue / max) * geometry.size.height
    
    return Capsule(style: .continuous)
      .fill(point.legend.color)
      .accessibilityLabel(Text(point.label))
      .accessibilityValue(Text(point.legend.label))
      .offset(y: y)
      .frame(height: CGFloat((point.endValue-point.startValue) / max) * geometry.size.height - topCut)
      .frame(maxWidth: maxBarWidth)
  }
  
  private func limitView(for limit: DataPoint,
                         in geometry: GeometryProxy) -> some View {
    let lineHeight = CGFloat(2)
    let y = -CGFloat(limit.endValue / self.max) * geometry.size.height - lineHeight/2
    
    return ZStack {
      RoundedRectangle(cornerRadius: lineHeight)
        .frame(height: lineHeight)
        .foregroundColor(limit.legend.color)
      Text(limit.label)
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
  static var previews: some View {
    BarsView(dataPoints: DataPoint.mockFewData,
             limit: DataPoint.mockLimit,
             showAxis: true,
             showLabels: true,
             everyNthLabel: nil,
             labelHeight: 22,
             maxBarWidth: 20)
    
    BarsView(dataPoints: DataPoint.mock,
             limit: nil,
             showAxis: true,
             showLabels: true,
             everyNthLabel: 3,
             labelHeight: 22,
             maxBarWidth: 20)
  }
}
#endif
