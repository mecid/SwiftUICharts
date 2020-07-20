//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LineChartView: View {
    let bars: [Bar]

    public init(bars: [Bar]) {
        self.bars = bars
    }

    private var gradient: LinearGradient {
        let colors = bars.map(\.legend).map(\.color)
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    ChartGrid(bars: bars)
                        .stroke(
                            Color.secondary,
                            style: StrokeStyle(
                                lineWidth: 1,
                                lineCap: .round,
                                lineJoin: .round,
                                miterLimit: 0,
                                dash: [1, 8],
                                dashPhase: 1
                            )
                        )
                    LineChart(bars: bars)
                        .fill(gradient)
                        .frame(minHeight: 100)
                }
                AxisView(bars: bars)
            }
            LabelsView(bars: bars)
            LegendView(bars: bars)
        }
    }
}

private struct LineChart: Shape {
    let bars: [Bar]
    var closePath: Bool = true

    func path(in rect: CGRect) -> Path {
        Path { path in
            let start = CGFloat(bars.first?.value ?? 0) / CGFloat(bars.max()?.value ?? 1)
            path.move(to: CGPoint(x: 0, y: rect.height - rect.height * start))
            let stepX = rect.width / CGFloat(bars.count)
            var currentX: CGFloat = 0
            bars.forEach {
                currentX += stepX
                let y = CGFloat($0.value / (bars.max()?.value ?? 1)) * rect.height
                path.addLine(to: CGPoint(x: currentX, y: rect.height - y))
            }

            if closePath {
                path.addLine(to: CGPoint(x: currentX, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.closeSubpath()
            }
        }
    }
}

#if DEBUG
struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(bars: Bar.mock)
    }
}
#endif
