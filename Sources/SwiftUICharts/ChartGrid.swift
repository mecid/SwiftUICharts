//
//  ChartGrid.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 7/4/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//

import SwiftUI

struct ChartGrid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))

            path.move(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))

            path.move(to: CGPoint(x: 0, y: rect.height / 2))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        }
    }
}

#if DEBUG
struct BarChartGrid_Previews: PreviewProvider {
    static var previews: some View {
        ChartGrid()
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
    }
}
#endif
