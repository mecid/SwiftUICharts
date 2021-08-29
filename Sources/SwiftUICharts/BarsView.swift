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
        HStack(alignment: .bottom, spacing: dataPoints.count > 40 ? 0 : 5) {
          ForEach(dataPoints.filter(\.visible), id: \.self) { bar in
            barView(for: bar, in: geometry)
          }
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.top)
        
        limit.map { limit in
          limitView(for: limit, in: geometry)
        }
      }
    }
  }
  
  private func barView(for point: DataPoint,
                       in geometry: GeometryProxy) -> some View {
    Capsule(style: .continuous)
      .fill(point.legend.color)
      .accessibilityLabel(Text(point.label))
      .accessibilityValue(Text(point.legend.label))
      .offset(y: -CGFloat(point.startValue / max) * geometry.size.height)
      .frame(height: CGFloat((point.endValue-point.startValue) / max) * geometry.size.height)
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
             maxBarWidth: 20)
    
    BarsView(dataPoints: DataPoint.mock,
             limit: nil,
             showAxis: true,
             maxBarWidth: 20)
  }
}
#endif
