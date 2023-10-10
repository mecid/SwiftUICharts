//
//  AxisView.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

struct AxisView: View {
    let dataPoints: [DataPoint]
    let maxY: Double?
    
    private var displayedMax: Double? {
        var vals = dataPoints.map({$0.endValue})
        if let maxY {
            vals.append(maxY)
        }
        return vals.max()
    }
    
    init(dataPoints: [DataPoint], maxY: Double? = nil) {
        self.dataPoints = dataPoints
        self.maxY = maxY
    }

    var body: some View {
        VStack {
            if let displayedMax {
                Text(String(Int(displayedMax)))
                    .foregroundColor(.accentColor)
                    .font(.caption)
                Spacer()
                Text(String(Int(displayedMax / 2)))
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
        Group {
            AxisView(dataPoints: [])
            
            AxisView(dataPoints: DataPoint.mock)
            
            AxisView(dataPoints: DataPoint.mock, maxY: 170.0)
        }
    }
}
#endif
