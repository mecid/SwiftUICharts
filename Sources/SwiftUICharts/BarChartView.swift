//
//  BarChartView.swift
//  SleepBot
//
//  Created by Majid Jabrayilov on 6/21/19.
//  Copyright © 2019 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct BarChartView: View {
    let bars: [Bar]
    var limit: Bar?
    var showAxis = true
    var showLabels = true
    var labelCount = 3
    var showLegends = true

    public init(
        bars: [Bar],
        limit: Bar? = nil,
        showAxis: Bool = true,
        showLabels: Bool = true,
        labelCount: Int = 3,
        showLegends: Bool = true
    ) {
        self.bars = bars
        self.limit = limit
        self.showAxis = showAxis
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                BarsView(bars: bars, limit: limit)

                if showAxis {
                    AxisView(bars: bars)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
            #if os(iOS)
            if showLabels {
                LabelsView(bars: bars, labelCount: labelCount)
                    .accessibility(hidden: true)
            }
            #endif
            if showLegends {
                LegendView(bars: limit.map { [$0] + bars} ?? bars)
                    .padding()
                    .accessibility(hidden: true)
            }
        }
    }
}

#if DEBUG
struct BarChartView_Previews : PreviewProvider {
    static var previews: some View {
        let limit = Legend(color: .purple, label: "Trend")
        let limitBar = Bar(value: 100, label: "Trend", legend: limit)
        return BarChartView(bars: Bar.mock, limit: limitBar)
    }
}
#endif
