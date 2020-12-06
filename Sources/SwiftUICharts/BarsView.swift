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
        guard let max = dataPoints.max()?.value, max != 0 else {
            return 1
        }
        return max
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                HStack(alignment: .bottom, spacing: dataPoints.count > 40 ? 0 : 2) {
                    ForEach(dataPoints.filter(\.visible), id: \.self) { bar in
                        Capsule(style: .continuous)
                            .fill(bar.legend.color)
                            .accessibilityLabel(Text(bar.label))
                            .accessibilityValue(Text(bar.legend.label))
                            .frame(height: CGFloat(bar.value / self.max) * geometry.size.height)
                    }
                }.frame(minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)

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
