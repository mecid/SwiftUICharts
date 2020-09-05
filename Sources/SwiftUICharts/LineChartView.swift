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
    let showAxis: Bool
    let showLabels: Bool
    let labelCount: Int
    let showLegends: Bool

    public init(
        dataPoints: [DataPoint],
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int = 3,
        showLegends: Bool = true
    ) {
        self.dataPoints = dataPoints
        self.showAxis = showAxis
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }

    private var gradient: LinearGradient {
        let colors = dataPoints.map(\.legend).map(\.color)
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private var grid: some View {
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
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack {
                    if showAxis {
                        grid
                    } else {
                        grid.hidden()
                    }

                    LineChart(dataPoints: dataPoints)
                        .fill(gradient)
                        .frame(minHeight: 100)
                }
                if showAxis {
                    AxisView(dataPoints: dataPoints)
                        .accessibility(hidden: true)
                }
            }
            if showLabels {
                LabelsView(dataPoints: dataPoints, labelCount: labelCount)
                    .accessibility(hidden: true)
            }

            if showLegends {
                LegendView(dataPoints: dataPoints)
                    .accessibility(hidden: true)
            }
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
