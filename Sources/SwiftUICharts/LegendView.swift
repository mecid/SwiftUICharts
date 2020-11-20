//
//  LegendView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LegendView<Content: View>: View {
    let legends: [Legend]

    private let pinView: () -> Content

    public init(dataPoints: [DataPoint], @ViewBuilder pinView: @escaping () -> Content) {
        legends = Array(Set(dataPoints.map { $0.legend })).sorted()
        self.pinView = pinView
    }

    public var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 100))], alignment: .leading) {
            ForEach(legends) { legend in
                HStack(alignment: .center) {
                    pinView()
                    Text(legend.label)
                }
                .foregroundColor(legend.color)
                .padding(4)
            }
        }
    }
}

#if DEBUG
struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(dataPoints: DataPoint.mock, pinView: { EmptyView() })
    }
}
#endif
