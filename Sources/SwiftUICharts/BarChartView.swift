//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// Type that defines a bar chart style.
public struct BarChartStyle: ChartStyle {
    public let barMinHeight: CGFloat
    public let showAxis: Bool
    public let axisLeadingPadding: CGFloat
    public let showLabels: Bool
    public let labelCount: Int?
    public let showLegends: Bool
    /**
     Creates new bar chart style with the following parameters.

     - Parameters:
        - barMinHeight: The minimal height for the bar that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.
        - axisLeadingPadding: Leading padding for axis line. Default is 0.
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the chart. Default is all.
        - showLegends: Bool value that controls whenever to show legends.
     */
    public init(
        barMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        axisLeadingPadding: CGFloat = 0,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true
    ) {
        self.barMinHeight = barMinHeight
        self.showAxis = showAxis
        self.axisLeadingPadding = axisLeadingPadding
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }
}

/// SwiftUI view that draws bars by placing them into a horizontal container.
public struct BarChartView: View {
    @Environment(\.chartStyle) var chartStyle

    let dataPoints: [DataPoint]
    let limit: DataPoint?

    /**
     Creates new bar chart view with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - limit: The horizontal line that will be drawn over bars. Default is nil.
     */
    public init(dataPoints: [DataPoint], limit: DataPoint? = nil) {
        self.dataPoints = dataPoints
        self.limit = limit
    }

    private var style: BarChartStyle {
        (chartStyle as? BarChartStyle) ?? .init()
    }

    private var grid: some View {
        ChartGrid(dataPoints: dataPoints)
            .stroke(
                style.showAxis ? Color.accentColor : .clear,
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

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    BarsView(dataPoints: dataPoints, limit: limit, showAxis: style.showAxis)
                        .frame(minHeight: style.barMinHeight)
                        .background(grid)

                    if style.showLabels {
                        LabelsView(
                            dataPoints: dataPoints,
                            labelCount: style.labelCount ?? dataPoints.count
                        ).accessibilityHidden(true)
                    }
                }
                if style.showAxis {
                    AxisView(dataPoints: dataPoints)
                        .fixedSize(horizontal: true, vertical: false)
                        .accessibilityHidden(true)
                        .padding(.leading, style.axisLeadingPadding)
                }
            }

            if style.showLegends {
                LegendView(dataPoints: limit.map { [$0] + dataPoints} ?? dataPoints)
                    .padding()
                    .accessibilityHidden(true)
            }
        }
    }
}

#if DEBUG
struct BarChartView_Previews : PreviewProvider {
    static var previews: some View {
        let limit = Legend(color: .purple, label: "Trend")
        let limitBar = DataPoint(value: 100, label: "Trend", legend: limit)
        return HStack(spacing: 0) {
            BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
            BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
        }.chartStyle(BarChartStyle(showLabels: false, showLegends: false))
    }
}
#endif
