//
//  AxisView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct AxisView: View {
    let dataPoints: [DataPoint]

    var body: some View {
        VStack {
            dataPoints.max().map {
                Text(String(Int($0.value)))
                    .foregroundColor(.accentColor)
                    .font(.caption)
            }
            Spacer()
            dataPoints.max().map {
                Text(String(Int($0.value / 2)))
                    .foregroundColor(.accentColor)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(dataPoints: DataPoint.mock)
    }
}
#endif
