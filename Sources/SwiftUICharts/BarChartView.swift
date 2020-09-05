//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct BarChartView: View {
    let dataPoints: [DataPoint]
    let limit: DataPoint?
    let barMinHeight: CGFloat
    let showAxis: Bool
    let showLabels: Bool
    let labelCount: Int
    let showLegends: Bool

    public init(
        dataPoints: [DataPoint],
        limit: DataPoint? = nil,
        barMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int = 3,
        showLegends: Bool = true
    ) {
        self.dataPoints = dataPoints
        self.limit = limit
        self.barMinHeight = barMinHeight
        self.showAxis = showAxis
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                BarsView(dataPoints: dataPoints, limit: limit, showAxis: showAxis)
                    .frame(minHeight: barMinHeight)

                if showAxis {
                    AxisView(dataPoints: dataPoints)
                        .fixedSize(horizontal: true, vertical: false)
                        .accessibilityHidden(true)
                }
            }
            if showLabels {
                LabelsView(dataPoints: dataPoints, labelCount: labelCount)
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
