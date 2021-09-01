//
//  AxisView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
//  RayWo, 30.08.2021
//
import SwiftUI

struct AxisView<BaseData: Hashable>: View {
  let dataPoints: [DataPoint<BaseData>]
  let gridLines: Int
  let showLabels: Bool
  let labelsHeight: CGFloat
  let toNearest: Int
  
  var body: some View {
    GeometryReader { geometry in
      let padding = showLabels ? labelsHeight : 0
      let count = gridLines - 1
      let step = CGFloat(maxLabelValue / CGFloat(count))
      let height = geometry.size.height - padding
      
      ForEach(0...count, id: \.self) { index in
        let y: CGFloat = height - (height / CGFloat(count) * CGFloat(index)) - 7
        
        Text(String(format: "%.0f", step * CGFloat(index)))
          .font(.caption)
          .foregroundColor(.accentColor)
          .offset(y: y)
      }
    }
    .frame(minWidth: 27)
  }
  
  private var maxValue: Double {
    guard let max = dataPoints.max() else { return 0.0 }
    
    return max.endValue
  }
  
  private var maxLabelValue: Double {
    round(maxValue + maxValue * 0.15, toNearest: Double(toNearest))
  }
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      ChartGridView(gridLines: 5, showLabels: true, labelsHeight: 22)
      AxisView<Int>(dataPoints: DataPoint.mock,
                    gridLines: 5,
                    showLabels: true,
                    labelsHeight: 22,
                    toNearest: 3)
        .padding(.leading)
    }
    .padding()
  }
}
#endif
