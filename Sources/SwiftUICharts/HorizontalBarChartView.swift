//
//  HorizontalBarChartView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 5/12/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// SwiftUI view that draws bars by placing them into a vertical container.
public struct HorizontalBarChartView: View {
	
    let dataPoints: [DataPoint]
    let barMaxWidth: CGFloat
	let text: ((_ bar: DataPoint) -> Text)?
	let maxValue: Double
	
	@ScaledMetric private var barHeight: CGFloat = 17
	@ScaledMetric private var circleSize: CGFloat = 8

    /**
     Creates new horizontal bar chart with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
        - barMaxWidth: The maximal width for the bar that presents the biggest value. Default is 100.
		- maxValue: The max value for calculating the bar width. Default is max value from the dataPoints.
		- text: The text to be shown next to the bar. Default is: bar.legend.label + ", " + bar.label
     */
	public init(dataPoints: [DataPoint], barMaxWidth: CGFloat = 100, maxValue: Double? = nil, text: ((_ bar: DataPoint) -> Text)? = nil) {
        self.dataPoints = dataPoints
        self.barMaxWidth = barMaxWidth
		self.text = text
		self.maxValue = max(maxValue ?? 1, dataPoints.max()?.value ?? 1)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(dataPoints, id: \.self) { bar in
                #if os(watchOS)
                VStack(alignment: .leading) {
					Capsule()
                        .foregroundColor(bar.legend.color)
                        .frame(width: CGFloat(bar.value / maxValue) * barMaxWidth, height: barHeight)
                    HStack {
                        Circle()
                            .foregroundColor(bar.legend.color)
                            .frame(width: circleSize, height: circleSize)

						Group {
							if let text = text?(bar) {
								text
							} else {
								Text(bar.legend.label) + Text(", ") + Text(bar.label)
							}
						}
						.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                #else
                HStack {
					Capsule()
                        .foregroundColor(bar.legend.color)
                        .frame(width: CGFloat(bar.value / maxValue) * barMaxWidth, height: barHeight)

                    Circle()
                        .foregroundColor(bar.legend.color)
                        .frame(width: circleSize, height: circleSize)

					Group {
						if let text = text?(bar) {
							text
						} else {
							Text(bar.legend.label) + Text(", ") + Text(bar.label)
						}
					}
					.frame(maxWidth: .infinity, alignment: .leading)
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

        return HorizontalBarChartView(dataPoints: dataPoints)
    }
}
