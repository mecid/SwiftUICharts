//
//  ChartGridView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 7/4/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
//  RayWo 30.08.2021
//

import SwiftUI

struct ChartGridView: View {
  
  let gridLines: Int
  let showLabels: Bool
  let labelsHeight: CGFloat
  
  var body: some View {
    let padding = showLabels ? labelsHeight : 0
    
    ChartGrid(lineCount: gridLines)
      .stroke(
        style: StrokeStyle(
          lineWidth: 1,
          lineCap: .round,
          lineJoin: .round,
          miterLimit: 0,
          dash: [1, 8],
          dashPhase: 0
        )
      )
      .foregroundColor(.accentColor)
      .padding(.bottom, padding)
  }
  
  private struct ChartGrid: Shape {
    var lineCount: Int
    
    func path(in rect: CGRect) -> Path {
      Path { path in
        for index in 0 ... lineCount {
          let y = rect.height / CGFloat(lineCount) * CGFloat(index)
          
          path.move(to: CGPoint(x: 0, y: y))
          path.addLine(to: CGPoint(x: rect.width, y: y))
        }
      }
    }
  }
}

#if DEBUG
struct ChartGridView_Previews: PreviewProvider {
  static var previews: some View {
    ChartGridView(gridLines: 6, showLabels: true, labelsHeight: 22)
  }
}
#endif
