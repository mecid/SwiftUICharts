//
//  BarsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/28/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct BarsView: View {
    let dataPoints: [DataPoint]
    let limit: DataPoint?
    let showAxis: Bool

    private var max: Double {
        if let max = dataPoints.map({ $0.value }).max(), max > 0 {
            return max
        } else {
            return 1
        }
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
                    dashPhase: 1
                )
            )
    }

    var body: some View {
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
                            .accessibility(label: Text(bar.label))
                            .accessibility(value: Text(bar.legend.label))
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
                    }
                    .alignmentGuide(VerticalAlignment.bottom) { $0[.bottom] - $0.height / 2 }
                    .offset(y: CGFloat(limit.value / self.max) * -geometry.size.height)
                }
            }
        }.frame(minHeight: 100)
    }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView(dataPoints: DataPoint.mock, limit: nil, showAxis: false)
    }
}
#endif
