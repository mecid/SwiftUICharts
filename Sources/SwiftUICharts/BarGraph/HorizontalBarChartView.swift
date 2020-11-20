//
//  HorizontalBarChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 5/12/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// SwiftUI view that draws bars by placing them into a vertical container.
public struct HorizontalBarChartView<Content: View>: View {
    let dataPoints: [DataPoint]
    let barMaxWidth: CGFloat

    private let legend: () -> Content
    private let barsView: () -> Content

    private var max: Double {
        guard let max = dataPoints.max()?.value, max != 0 else { return 1 }
        return max
    }

    /**
     Creates new horizontal bar chart with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - barMaxWidth: The maximal width for the bar that presents the biggest value. Default is 100.
     */
    public init(dataPoints: [DataPoint],
                barMaxWidth: CGFloat = 100,
                @ViewBuilder legend: @escaping () -> Content,
                @ViewBuilder barsView: @escaping () -> Content) {
        self.dataPoints = dataPoints
        self.barMaxWidth = barMaxWidth
        self.legend = legend
        self.barsView = barsView
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(dataPoints) { bar in
                #if os(watchOS)
                VStack(alignment: .leading) {
                    barsView()
                        .foregroundColor(bar.legend.color)
                        .frame(width: CGFloat(bar.value / max) * barMaxWidth)

                    HStack {
                        legend()
                        Text(bar.legend.label) + Text(", ") + Text(bar.label)

                        // TODO: temp fix
                        Spacer()
                    }
                }
                #else
                HStack {
                    barsView()
                        .foregroundColor(bar.legend.color)
                        .frame(width: CGFloat(bar.value / max) * barMaxWidth)

                    legend()
                    Text(bar.legend.label) + Text(", ") + Text(bar.label)

                    // TODO: temp fix
                    Spacer()
                }
                #endif
            }
        }
    }
}

struct HorizontalBarChart_Previews: PreviewProvider {
    static var previews: some View {
        let veryLow = Legend(color: .black, label: "Very Low")
        let low = Legend(color: .gray, label: "Low")
        let resting = Legend(color: .blue, label: "Resting")
        let highResting = Legend(color: .orange, label: "High Resting")
        let elevated = Legend(color: .red, label: "Elevated")

        let dataPoints: [DataPoint] = [
            DataPoint(value: 0.1, label: "10%", legend: veryLow),
            DataPoint(value: 0.15, label: "15%", legend: low),
            DataPoint(value: 0.60, label: "60%", legend: resting),
            DataPoint(value: 0.1, label: "10%", legend: highResting),
            DataPoint(value: 0.05, label: "5%", legend: elevated)
        ]

        return HorizontalBarChartView(dataPoints: dataPoints,
                                      legend: { EmptyView() },
                                      barsView: { EmptyView() })
    }
}
