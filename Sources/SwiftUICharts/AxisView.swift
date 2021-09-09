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

struct AxisView<BaseData>: View {
  let dataPoints: [DataPoint<BaseData>]
  let gridLines: Int
  let roundTo: Double
  let showLabels: Bool
  let labelsHeight: CGFloat
  let maxValue: Double
  let maxLabelValue: Double
  let step: Double
  
  @State private var labelSize: CGSize = .zero
  
  var body: some View {
    GeometryReader { geometry in
      SizePropagator(id: UUID(), content: labelView(in: geometry.frame(in: .local)))
        .onPreferenceChange(SizePreferenceKey.self) { value in
          labelSize = value.size
        }
    }
    .frame(width: labelSize.width)
  }
  
  private var formatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = fractionDigits
    formatter.maximumFractionDigits = fractionDigits
    
    return formatter
  }
  
  private var fractionDigits: Int {
    var result = 0
    var intValue: Int = Int(roundTo)
    var remainder: Double = roundTo - Double(intValue)
    
    while remainder > 0 {
      result += 1
      
      remainder *= 10
      intValue = Int(remainder)
      remainder = remainder - Double(intValue)
    }
    
    return result
  }
  
  private func labelView(in rect: CGRect) -> some View {
    let padding = showLabels ? labelsHeight : 0
    let height = rect.size.height - padding
    
    return ForEach(0 ... gridLines, id: \.self) { index in
      let y: CGFloat = height - (height / CGFloat(gridLines) * CGFloat(index)) - 7
      let value = NSNumber(value: step * CGFloat(index))
      
      Text(formatter.string(from: value) ?? "")
        .font(.caption)
        .foregroundColor(.accentColor)
        .offset(y: y)
    }
  }
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
  static var dataPoints = DataPoint<Int>.mockFewData
  
  static var maxValue: Double {
    guard let max = dataPoints.max() else { return 0.0 }
    
    return max.endValue
  }
  
  static var maxLabelValue: Double {
    round(maxValue + maxValue * 0.15, toNearest: Double(2))
  }
  
  static var previews: some View {
    ZStack {
      HStack {
        ChartGridView(gridLines: 5, showLabels: true, labelsHeight: 22)
        AxisView<Int>(dataPoints: dataPoints,
                      gridLines: 5,
                      roundTo: 2,
                      showLabels: true,
                      labelsHeight: 22,
                      maxValue: 109,
                      maxLabelValue: 126,
                      step: 14)
          .padding(.leading)
      }
      
      VStack {
        Text("max: \(maxValue)")
        Text("max label \(maxLabelValue)")
      }
    }
    .padding()
    
    ZStack {
      HStack {
        ChartGridView(gridLines: 5, showLabels: true, labelsHeight: 22)
        AxisView<Int>(dataPoints: dataPoints,
                      gridLines: 5,
                      roundTo: 2,
                      showLabels: true,
                      labelsHeight: 22,
                      maxValue: maxValue,
                      maxLabelValue: maxLabelValue,
                      step: 20)
          .padding(.leading)
      }
      
      VStack {
        Text("max: \(maxValue)")
        Text("max label \(maxLabelValue)")
      }
    }
    .padding()
  }
}
#endif
