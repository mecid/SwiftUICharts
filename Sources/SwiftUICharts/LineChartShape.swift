//
//  SwiftUIView.swift
//  
//
//  Created by Majid Jabrayilov on 24.09.20.
//
import SwiftUI

public struct LineChartShape: Shape {
    let dataPoints: [DataPoint]
    let closePath: Bool
    let showPin: Bool

    private var shouldShowPin: Bool {
        showPin && !dataPoints.isEmpty && !closePath
    }

    public init(dataPoints: [DataPoint], closePath: Bool = true, showPin: Bool = false) {
        self.dataPoints = dataPoints
        self.closePath = closePath
        self.showPin = showPin
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let startY = CGFloat(dataPoints.first?.value ?? 0) / CGFloat(dataPoints.max()?.value ?? 1)
            let stepX = rect.width / CGFloat(dataPoints.count)
            path.move(to: CGPoint(x: stepX * 0.5, y: rect.height - rect.height * startY))
            var currentX: CGFloat = stepX * 0.5

            dataPoints.dropFirst().forEach {
                currentX += stepX
                let y = CGFloat($0.value / (dataPoints.max()?.value ?? 1)) * rect.height
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
        LineChartShape(dataPoints: DataPoint.mock, closePath: true)
    }
}
#endif
