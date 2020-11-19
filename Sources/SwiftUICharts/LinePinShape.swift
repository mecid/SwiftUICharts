//
//  SwiftUIView.swift
//  
//
//  Created by Majid Jabrayilov on 24.09.20.
//
import SwiftUI

public struct LinePinShape: Shape {
    let dataPoints: [DataPoint]
    let pinSize: CGSize

    public init(dataPoints: [DataPoint], pinSize: CGSize = .init(width: 8, height: 8)) {
        self.dataPoints = dataPoints
        self.pinSize = pinSize
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            let startY = CGFloat(dataPoints.first?.value ?? 0) / CGFloat(dataPoints.max()?.value ?? 1)
            let stepX = rect.width / CGFloat(dataPoints.count)
            path.move(to: CGPoint(x: stepX * 0.5 - pinSize.width * 0.5, y: rect.height - rect.height * startY))
            var currentX: CGFloat = stepX * 0.5 - pinSize.width * 0.5

            if !dataPoints.isEmpty {
                let rect = CGRect(x: currentX,
                                  y: rect.height - rect.height * startY - pinSize.width / 2,
                                  width: pinSize.width,
                                  height: pinSize.height)
                path.addPath(Circle().path(in: rect))
            }

            dataPoints.dropFirst().forEach {
                currentX += stepX
                let y = CGFloat($0.value / (dataPoints.max()?.value ?? 1)) * rect.height
                let rect = CGRect(x: currentX,
                                  y: rect.height - y - pinSize.width / 2,
                                  width: pinSize.width,
                                  height: pinSize.height)
                path.addPath(Circle().path(in: rect))
            }
        }
    }
}

#if DEBUG
struct LinePinShape_Previews: PreviewProvider {
    static var previews: some View {
        LinePinShape(dataPoints: DataPoint.mock)
    }
}
#endif
