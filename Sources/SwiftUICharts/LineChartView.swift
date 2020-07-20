//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LineChartView: View {
    let dataPoints: [DataPoint]

    public init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }

    private var gradient: LinearGradient {
        let colors = dataPoints.map(\.legend).map(\.color)
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
                    ChartGrid(dataPoints: dataPoints)
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
                    LineChart(dataPoints: dataPoints)
                        .fill(gradient)
                        .frame(minHeight: 100)
                }
                AxisView(dataPoints: dataPoints)
            }
            LabelsView(dataPoints: dataPoints)
            LegendView(dataPoints: dataPoints)
        }
    }
}

private struct LineChart: Shape {
    let dataPoints: [DataPoint]
    var closePath: Bool = true

    func path(in rect: CGRect) -> Path {
        Path { path in
            let start = CGFloat(dataPoints.first?.value ?? 0) / CGFloat(dataPoints.max()?.value ?? 1)
            path.move(to: CGPoint(x: 0, y: rect.height - rect.height * start))
            let stepX = rect.width / CGFloat(dataPoints.count)
            var currentX: CGFloat = 0
            dataPoints.forEach {
                currentX += stepX
                let y = CGFloat($0.value / (dataPoints.max()?.value ?? 1)) * rect.height
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
        LineChartView(dataPoints: DataPoint.mock)
    }
}
#endif
