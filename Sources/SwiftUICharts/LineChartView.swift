//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// Type that defines a line chart style.
public struct LineChartStyle: ChartStyle {
    public let lineMinHeight: CGFloat
    public let showAxis: Bool
    public let axisLeadingPadding: CGFloat
    public let showLabels: Bool
    public let labelCount: Int?
    public let showLegends: Bool

    /**
     Creates new line chart style with the following parameters.

     - Parameters:
        - lineMinHeight: The minimal height for the point that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.
        - axisLeadingPadding: Leading padding for axis line. Default is 0.
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the the chart.
        - showLegends: Bool value that controls whenever to show legends.
     */

    public init(
        lineMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        axisLeadingPadding: CGFloat = 0,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true
    ) {
        self.lineMinHeight = lineMinHeight
        self.showAxis = showAxis
        self.axisLeadingPadding = axisLeadingPadding
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }
}

/// SwiftUI view that draws data points by drawing a line.
public struct LineChartView: View {
    @Environment(\.chartStyle) var chartStyle
    let dataPoints: [DataPoint]

    /**
     Creates new line chart view with the following parameters.

     - Parameters:
     - dataPoints: The array of data points that will be used to draw the bar chart.
     */
    public init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }

    private var style: LineChartStyle {
        (chartStyle as? LineChartStyle) ?? .init()
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
                style.showAxis ? Color.secondary : .clear,
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
                LineChartShape(dataPoints: dataPoints)
                    .fill(gradient)
                    .frame(minHeight: style.lineMinHeight)
                    .background(grid)

                if style.showAxis {
                    AxisView(dataPoints: dataPoints)
                        .accessibilityHidden(true)
                        .padding(.leading, style.axisLeadingPadding)
                }
            }

            if style.showLabels {
                LabelsView(dataPoints: dataPoints, labelCount: style.labelCount ?? dataPoints.count)
                    .accessibilityHidden(true)
            }

            if style.showLegends {
                LegendView(dataPoints: dataPoints)
                    .padding()
                    .accessibilityHidden(true)
            }
        }
    }
}

#if DEBUG
struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LineChartView(dataPoints: DataPoint.mock)
            LineChartView(dataPoints: DataPoint.mock)
        }.chartStyle(LineChartStyle(showAxis: false, showLabels: false))
    }
}
#endif
