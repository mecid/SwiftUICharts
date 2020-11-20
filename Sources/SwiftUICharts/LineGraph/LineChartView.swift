//
//  LineChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//

import SwiftUI

/// SwiftUI view that draws data points by drawing a line.
public struct LineChartView<Content: View>: View {
    let dataPoints: [DataPoint]
    let lineMinHeight: CGFloat
    let showAxis: Bool
    let showLabels: Bool
    let labelCount: Int?

    private let grid: () -> Content
    private let legend: () -> Content
    private let lineShape: () -> Content
    private let pinShape: () -> Content
    private let axisView: () -> Content
    private let labelsView: () -> Content

    /**
     Creates new line chart view with the following parameters.

     - Parameters:
     - dataPoints: The array of data points that will be used to draw the bar chart.
     - lineMinHeight: The minimal height for the point that presents the biggest value. Default is 100.
     - showAxis: Bool value that controls whenever to show axis.
     - showLabels: Bool value that controls whenever to show labels.
     - labelCount: The count of labels that should be shown below the chart. Default is dataPoints.count unless you specify a value.
     */
    public init(
        dataPoints: [DataPoint],
        lineMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        @ViewBuilder grid: @escaping () -> Content,
        @ViewBuilder legend: @escaping () -> Content,
        @ViewBuilder lineShape: @escaping () -> Content,
        @ViewBuilder pinShape: @escaping () -> Content,
        @ViewBuilder axisView: @escaping () -> Content,
        @ViewBuilder labelsView: @escaping () -> Content
    ) {
        self.dataPoints = dataPoints
        self.lineMinHeight = lineMinHeight
        self.showAxis = showAxis
        self.showLabels = showLabels
        self.labelCount = labelCount

        self.grid = grid
        self.legend = legend
        self.lineShape = lineShape
        self.pinShape = pinShape
        self.axisView = axisView
        self.labelsView = labelsView
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    ZStack {
                        if showAxis {
                            grid()
                        } else {
                            grid().hidden()
                        }

                        lineShape()
                        pinShape()
                    }

                    if showLabels { labelsView() }
                }

                if showAxis { axisView() }
            }

            legend()
        }
    }
}

#if DEBUG
struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(dataPoints: DataPoint.mock,
                      grid: { EmptyView() },
                      legend: { EmptyView() },
                      lineShape: { EmptyView() },
                      pinShape: { EmptyView() },
                      axisView: { EmptyView() },
                      labelsView: { EmptyView() })
    }
}
#endif
