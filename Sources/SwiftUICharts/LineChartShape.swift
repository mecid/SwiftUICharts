//
//  LineChartShape.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 24.09.20.
//
import SwiftUI

struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    var closePath: Bool
    let maxY: Double?
    
    private let displayedMaxY: Double
    
    init(dataPoints: [DataPoint], closePath: Bool = true, maxY: Double? = nil) {
        self.dataPoints = dataPoints
        self.closePath = closePath
        self.maxY = maxY
        
        var vals = dataPoints.map({$0.endValue})
        if let maxY {
            vals.append(maxY)
        }
        self.displayedMaxY = vals.max() ?? 1.0
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            let start = CGFloat(dataPoints.first?.endValue ?? 0) / CGFloat(displayedMaxY)
            path.move(to: CGPoint(x: 0, y: rect.height - rect.height * start))
            let stepX = rect.width / CGFloat(dataPoints.count)
            var currentX: CGFloat = 0
            dataPoints.forEach {
                currentX += stepX
                let y = CGFloat($0.endValue / displayedMaxY) * rect.height
                path.addLine(to: CGPoint(x: currentX, y: rect.height - y))
            }

            if closePath {
                path.addLine(to: CGPoint(x: currentX, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.closeSubpath()
            }
        }
    }
}

#if DEBUG
struct LineChartShape_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LineChartShape(dataPoints: DataPoint.mock, closePath: true, maxY: nil)
            LineChartShape(dataPoints: DataPoint.mock, closePath: true, maxY: 320.0)
        }
    }
}
#endif
