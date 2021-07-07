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
                Text(string(from: $0.endValue))
                    .foregroundColor(.accentColor)
                    .font(.caption)
            }
            Spacer()
            dataPoints.max().map {
                Text(string(from: $0.endValue / 2))
                    .foregroundColor(.accentColor)
                    .font(.caption)
            }
            Spacer()
        }
    }
    
    private func string(from value: Double) -> String {
        guard let formatter = valueFormatter else {
            return String(Int(value))
        }
        
        return formatter(value)
    }
    
    @Environment(\.axisValueFormatter) private var valueFormatter
}

#if DEBUG
struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(dataPoints: DataPoint.mock)
    }
}
#endif
