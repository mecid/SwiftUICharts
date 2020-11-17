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
    let axisColor: Color
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
        - axisLeadingPadding: Leading padding value for axis.
        - axisColor: Axis and labels color. Default is `.secondary`
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the chart. Default is dataPoints.count unless you specify a value.
        - showLegends: Bool value that controls whenever to show legends.
     */
    public init(
        dataPoints: [DataPoint],
        limit: DataPoint? = nil,
        barMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        axisColor: Color = .secondary,
        axisLeadingPadding: CGFloat = 0,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true
    ) {
        self.dataPoints = dataPoints
        self.limit = limit
        self.barMinHeight = barMinHeight
        self.showAxis = showAxis
        self.axisColor = axisColor
        self.axisLeadingPadding = axisLeadingPadding
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                BarsView(dataPoints: dataPoints, limit: limit, showAxis: showAxis, axisColor: axisColor)
                    .frame(minHeight: barMinHeight)

                if showAxis {
                    AxisView(dataPoints: dataPoints, axisColor: axisColor)
                        .padding(.leading, axisLeadingPadding)
                        .fixedSize(horizontal: true, vertical: false)
                        .accessibilityHidden(true)
                }
            }
            if showLabels {
                LabelsView(dataPoints: dataPoints, axisColor: axisColor, labelCount: labelCount ?? dataPoints.count)
                    .accessibilityHidden(true)
            }
            if showLegends {
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
        return BarChartView(dataPoints: DataPoint.mock, limit: limitBar)
    }
}
#endif
