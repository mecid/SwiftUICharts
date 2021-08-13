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
        guard let max = dataPoints.max()?.endValue, max != 0 else {
            return 1
        }
        return max
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                HStack(alignment: .bottom, spacing: dataPoints.count > 40 ? 0 : 2) {
                    ForEach(dataPoints.filter(\.visible), id: \.self) { bar in
                        barView(for: bar, in: geometry)
                    }
                }.frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)

                limit.map { limit in
                    limitView(for: limit, in: geometry)
                }
            }
        }
    }

    private func barView(for point: DataPoint, in geometry: GeometryProxy) -> some View {
        Capsule(style: .continuous)
            .fill(point.legend.color)
            .accessibilityLabel(Text(point.label))
            .accessibilityValue(Text(point.legend.label))
            .offset(y: -CGFloat(point.startValue / max) * geometry.size.height)
            .frame(height: CGFloat((point.endValue-point.startValue) / max) * geometry.size.height)
    }

    private func limitView(for limit: DataPoint, in geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .frame(height: 4)
                .foregroundColor(limit.legend.color)
            Text(limit.label)
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(limit.legend.color)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        }.offset(y: CGFloat(limit.endValue / self.max) * geometry.size.height / -2)
    }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView(dataPoints: DataPoint.mock, limit: nil, showAxis: true)
    }
}
#endif
