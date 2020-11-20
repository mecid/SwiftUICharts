//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// SwiftUI view that draws bars by placing them into a horizontal container.
public struct BarChartView<Content: View>: View {
    let dataPoints: [DataPoint]
    let limit: DataPoint?
    let barMinHeight: CGFloat
    let showAxis: Bool
    let showLabels: Bool
    let labelCount: Int?
    let showLegends: Bool

    private let legend: () -> Content
    private let barsView: () -> Content
    private let axisView: () -> Content
    private let labelsView: () -> Content

    /**
     Creates new bar chart view with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - limit: The horizontal line that will be drawn over bars. Default is nil.
        - barMinHeight: The minimal height for the bar that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.      
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the chart. Default is dataPoints.count unless you specify a value.
        - showLegends: Bool value that controls whenever to show legends.
     */
    public init(
        dataPoints: [DataPoint],
        limit: DataPoint? = nil,
        barMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true,
        @ViewBuilder legend: @escaping () -> Content,
        @ViewBuilder barsView: @escaping () -> Content,
        @ViewBuilder axisView: @escaping () -> Content,
        @ViewBuilder labelsView: @escaping () -> Content
    ) {
        self.dataPoints = dataPoints
        self.limit = limit
        self.barMinHeight = barMinHeight
        self.showAxis = showAxis
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends

        self.legend = legend
        self.barsView = barsView
        self.axisView = axisView
        self.labelsView = labelsView
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    barsView()

                    if showLabels { labelsView() }
                }

                if showAxis { axisView() }
            }
            
            if showLegends { legend() }
        }
    }
}

#if DEBUG
struct BarChartView_Previews : PreviewProvider {
    static var previews: some View {
        let limit = Legend(color: .purple, label: "Trend")
        let limitBar = DataPoint(value: 100, label: "Trend", legend: limit)
        return BarChartView(dataPoints: DataPoint.mock,
                            limit: limitBar,
                            legend: { EmptyView() },
                            barsView: { EmptyView() },
                            axisView: { EmptyView() },
                            labelsView: { EmptyView() })
    }
}
#endif
