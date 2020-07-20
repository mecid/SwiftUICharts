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
    var labelCount = 3

    private var threshold: Int {
        let threshold = dataPoints.count / labelCount

        switch threshold {
        case 0...1: return 1
        case 1...2: return 2
        default: return threshold
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(dataPoints.indexed(), id: \.1.self) { index, bar in
                if index % self.threshold == 0 {
                    Text(bar.label)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
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
        LabelsView(dataPoints: DataPoint.mock)
    }
}
#endif
