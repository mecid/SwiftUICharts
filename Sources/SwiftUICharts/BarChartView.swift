//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// SwiftUI view that draws bars by placing them into a horizontal container.
public struct BarChartView: View {
    let dataPoints: [DataPoint]
    let limit: DataPoint?
    let barMinHeight: CGFloat
    let showAxis: Bool
    let axisLeadingPadding: CGFloat
    let showLabels: Bool
    let labelCount: Int?
    let showLegends: Bool

    /**
     Creates new bar chart view with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - limit: The horizontal line that will be drawn over bars. Default is nil.
        - barMinHeight: The minimal height for the bar that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the chart. Default is all.
        - showLegends: Bool value that controls whenever to show legends.
     */
    public init(
        dataPoints: [DataPoint],
        limit: DataPoint? = nil,
        barMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        axisLeadingPadding: CGFloat = 0,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true
    ) {
        self.dataPoints = dataPoints
        self.limit = limit
        self.barMinHeight = barMinHeight
        self.showAxis = showAxis
        self.axisLeadingPadding = axisLeadingPadding
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }

    private var grid: some View {
        ChartGrid(dataPoints: dataPoints)
            .stroke(
                showAxis ? Color.accentColor : .clear,
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
                    BarsView(dataPoints: dataPoints, limit: limit, showAxis: showAxis)
                        .frame(minHeight: barMinHeight)
                        .overlay(grid)

                    if showLabels {
                        LabelsView(
                            dataPoints: dataPoints,
                            labelCount: labelCount ?? dataPoints.count
                        ).accessibilityHidden(true)
                    }
                }
                if showAxis {
                    AxisView(dataPoints: dataPoints)
                        .fixedSize(horizontal: true, vertical: false)
                        .accessibilityHidden(true)
                        .padding(.leading, axisLeadingPadding)
                }
            }

            if showLegends {
                LegendView(dataPoints: limit.map { [$0] + dataPoints} ?? dataPoints)
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
        return BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
    }
}
#endif
