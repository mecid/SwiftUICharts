//
//  HorizontalBarChart.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 5/12/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct HorizontalBarChart: View {
    let bars: [Bar]

    public init(bars: [Bar]) {
        self.bars = bars
    }

    var max: Double { bars.max()?.value ?? 0}

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(bars, id: \.self) { bar in
                HStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .foregroundColor(bar.legend.color)
                        .frame(width: CGFloat(bar.value / self.max) * 100, height: 16)

                    Circle()
                        .foregroundColor(bar.legend.color)
                        .frame(width: 8, height: 8)

                    Text(bar.legend.label) + Text(", ") + Text(bar.label)
                }
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

        let bars: [Bar] = [
            Bar(value: 0.1, label: "10%", legend: veryLow),
            Bar(value: 0.15, label: "15%", legend: low),
            Bar(value: 0.60, label: "60%", legend: resting),
            Bar(value: 0.1, label: "10%", legend: highResting),
            Bar(value: 0.05, label: "5%", legend: elevated)
        ]

        return List {
            return HorizontalBarChart(bars: bars)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
