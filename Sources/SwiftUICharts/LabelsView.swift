//
//  LabelsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

public struct LabelsView: View {
    let dataPoints: [DataPoint]
    let labelColor: Color
    let labelCount: Int

    private var threshold: Int {
        let threshold = Double(dataPoints.count) / Double(labelCount)
        return Int(threshold.rounded(.awayFromZero))
    }

    public init(dataPoints: [DataPoint], axisColor: Color, labelCount: Int? = nil) {
        self.dataPoints = dataPoints
        self.labelColor = axisColor
        self.labelCount = labelCount ?? dataPoints.count
    }

    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(dataPoints.indexed(), id: \.1.self) { index, bar in
                    if index % self.threshold == 0 {
                        Text(bar.label)
                            .multilineTextAlignment(.center)
                            .foregroundColor(labelColor)
                            .font(.caption)
                            .frame(width: geometry.size.width / CGFloat(labelCount), alignment: .center)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct LabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelsView(dataPoints: DataPoint.mock, axisColor: .secondary)
    }
}
#endif
