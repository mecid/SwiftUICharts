//
//  LabelsView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct LabelsView: View {
    let dataPoints: [DataPoint]
    let labelCount: Int

    private var threshold: Int {
        let threshold = Double(dataPoints.count) / Double(labelCount)
        return Int(threshold.rounded(.awayFromZero))
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(dataPoints.indexed(), id: \.1.self) { index, bar in
                if index % self.threshold == 0 {
                    Text(bar.label)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.accentColor)
                        .font(.caption)
                    Spacer()
                }
            }
        }
    }
}

#if DEBUG
struct LabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LabelsView(dataPoints: DataPoint.mock, labelCount: 3)
    }
}
#endif
