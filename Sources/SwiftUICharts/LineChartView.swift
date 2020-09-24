//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// SwiftUI view that draws data points by drawing a line.
public struct LineChartView: View {
    let dataPoints: [DataPoint]
    let lineMinHeight: CGFloat
    let showAxis: Bool
    let showLabels: Bool
    let labelCount: Int
    let showLegends: Bool

    /**
     Creates new line chart view with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - lineMinHeight: The minimal height for the point that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the the chart.
        - showLegends: Bool value that controls whenever to show legends.
     */
    public init(
        dataPoints: [DataPoint],
        lineMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int = 3,
        showLegends: Bool = true
    ) {
        self.dataPoints = dataPoints
        self.lineMinHeight = lineMinHeight
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

                    LineChartShape(dataPoints: dataPoints)
                        .fill(gradient)
                        .frame(minHeight: lineMinHeight)
                }
                if showAxis {
                    AxisView(dataPoints: dataPoints)
                        .accessibilityHidden(true)
                }
            }
            if showLabels {
                LabelsView(dataPoints: dataPoints, labelCount: labelCount)
                    .accessibilityHidden(true)
            }

            if showLegends {
                LegendView(dataPoints: dataPoints)
                    .accessibilityHidden(true)
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
