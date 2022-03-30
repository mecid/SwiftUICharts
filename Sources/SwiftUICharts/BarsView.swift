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

    private enum Size {
        static let cornerRadius: CGFloat = 4
        static let limitHeight: CGFloat = 4

        static func spacing(for count: Int) -> CGFloat {
            return count > 40 ? 0 : 2
        }
    }

    private var max: Double {
        var allDataPoints = dataPoints

        if let limit = limit {
            allDataPoints.append(limit)
        }

        return allDataPoints.max()?.endValue ?? 0
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                HStack(alignment: .bottom, spacing: Size.spacing(for: dataPoints.count)) {
                    ForEach(dataPoints.filter(\.visible), id: \.self) { bar in
                        barView(for: bar, in: geometry)
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)

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
            RoundedRectangle(cornerRadius: Size.cornerRadius, style: .continuous)
                .frame(height: Size.limitHeight)
                .foregroundColor(limit.legend.color)
            Text(limit.label)
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(limit.legend.color)
                .clipShape(RoundedRectangle(cornerRadius: Size.cornerRadius, style: .continuous))
        }
        .offset(y: -CGFloat((limit.endValue-Size.limitHeight/2) / self.max) * geometry.size.height)
    }
}

#if DEBUG
struct BarsView_Previews: PreviewProvider {
    static var previews: some View {
        BarsView(dataPoints: DataPoint.mock, limit: nil, showAxis: true)
    }
}
#endif
