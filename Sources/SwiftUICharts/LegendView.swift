//
//  LegendView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LegendView: View {
    let legends: [Legend]

    public init(dataPoints: [DataPoint]) {
        legends = Array(Set(dataPoints.map { $0.legend })).sorted()
    }

    public var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 100))], alignment: .leading) {
            ForEach(legends) { legend in
                HStack(alignment: .center) {
                    Circle()
                        .fill(legend.color)
                        .frame(width: 16, height: 16)

                    Text(legend.label)
                        .foregroundColor(legend.color)
                }
                .padding(4)
            }
        }
    }
}

#if DEBUG
struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(dataPoints: DataPoint.mock)
    }
}
#endif
