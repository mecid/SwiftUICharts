//
//  AxisView.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct AxisView: View {
    let bars: [Bar]

    var body: some View {
        VStack {
            bars.max().map {
                Text(String(Int($0.value)))
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            Spacer()
            bars.max().map {
                Text(String(Int($0.value / 2)))
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(bars: Bar.mock)
    }
}
#endif
