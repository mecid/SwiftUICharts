//
//  BarsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/28/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct BarsView: View {
    let dataPoints: [DataPoint]
    let limit: DataPoint?
    let showAxis: Bool
    
    /**
      Creates new horizontal bar chart with the following parameters.

      - Parameters:
         - dataPoints: The array of data points that will be used to draw the bar chart.
         - limit: The limit indicator that will be used to draw a horizontal line in the bar chart.
         - showAxis: Show or hide the horizontal and vertical axis in the bar chart.
     */
    public init(dataPoints: [DataPoint], limit: DataPoint?, showAxis: Bool) {
        self.dataPoints = dataPoints
        self.limit = limit
        self.showAxis = showAxis
    }

    private var max: Double {
        guard let max = dataPoints.max()?.value, max != 0 else {
            return 1
        }
        return max
    }

    private var grid: some View {
        ChartGrid(dataPoints: dataPoints)
            .stroke(
                Color.secondary,
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
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                if showAxis {
                    grid
                } else {
                    grid.hidden()
                }

                HStack(alignment: .bottom, spacing: dataPoints.count > 40 ? 0 : 2) {
                    ForEach(dataPoints.filter(\.visible), id: \.self) { bar in
                        Capsule(style: .continuous)
                            .fill(bar.legend.color)
                            .accessibilityLabel(Text(bar.label))
                            .accessibilityValue(Text(bar.legend.label))
                            .frame(height: CGFloat(bar.value / self.max) * geometry.size.height)
                    }
                }

                limit.map { limit in
                    ZStack {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .frame(height: 4)
                            .foregroundColor(limit.legend.color)
                        Text(limit.label)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(limit.legend.color)
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    }.offset(y: CGFloat(limit.value / self.max) * geometry.size.height / -2)
                }
            }
        }
    }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView(dataPoints: DataPoint.mock, limit: nil, showAxis: true)
    }
}
#endif
