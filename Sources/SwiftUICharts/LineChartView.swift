//
//  LineChartView.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 6/27/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// Type that defines a line chart style.
public struct LineChartStyle: ChartStyle {
    /// Type that defines the style of line drawing.
    public enum Drawing {
        case fill
        case stroke(width: CGFloat = 1)
    }
    
    /// Minimal height for a line chart view.
    public let lineMinHeight: CGFloat
    /// Boolean value indicating whenever show chart axis.
    public let showAxis: Bool
    /// Leading padding for the value axis displayed in the chart.
    public let axisLeadingPadding: CGFloat
    /// Boolean value indicating whenever show chart labels.
    public let showLabels: Bool
    /// The count of labels that should be shown below the chart. Nil value shows all the labels.
    public let labelCount: Int?
    public let showLegends: Bool
    
    /// Value that controls type of drawing.
    public let drawing: Drawing

    /**
     Creates new line chart style with the following parameters.

     - Parameters:
        - lineMinHeight: The minimal height for the point that presents the biggest value. Default is 100.
        - showAxis: Bool value that controls whenever to show axis.
        - axisLeadingPadding: Leading padding for axis line. Default is 0.
        - showLabels: Bool value that controls whenever to show labels.
        - labelCount: The count of labels that should be shown below the the chart. Default is all.
        - showLegends: Bool value that controls whenever to show legends.
        - drawing: Value that controls type of drawing. Default is fill.
     */

    public init(
        lineMinHeight: CGFloat = 100,
        showAxis: Bool = true,
        axisLeadingPadding: CGFloat = 0,
        showLabels: Bool = true,
        labelCount: Int? = nil,
        showLegends: Bool = true,
        drawing: Drawing = .fill
    ) {
        self.lineMinHeight = lineMinHeight
        self.showAxis = showAxis
        self.axisLeadingPadding = axisLeadingPadding
        self.showLabels = showLabels
        self.labelCount = labelCount
        self.showLegends = showLegends
        self.drawing = drawing
    }
}

/// SwiftUI view that draws data points by drawing a line.
public struct LineChartView: View {
    @Environment(\.chartStyle) var chartStyle
    let dataPoints: [DataPoint]

    /**
     Creates new line chart view with the following parameters.

     - Parameters:
        - dataPoints: The array of data points that will be used to draw the bar chart.
     */
    public init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }

    private var style: LineChartStyle {
        (chartStyle as? LineChartStyle) ?? .init()
    }

    private var gradient: LinearGradient {
        let colors = dataPoints.map(\.legend).map(\.color)
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private var grid: some View {
        ChartGrid()
            .stroke(
                style.showAxis ? Color.secondary : .clear,
                style: StrokeStyle(
                    lineWidth: 1,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: 0,
                    dash: [1, 8],
                    dashPhase: 1
                )
            )
    }

    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                if case let LineChartStyle.Drawing.stroke(width) = style.drawing {
                    LineChartShape(dataPoints: dataPoints, closePath: false)
                        .stroke(gradient, style: .init(lineWidth: width))
                        .frame(minHeight: style.lineMinHeight)
                        .background(grid)
                } else {
                    LineChartShape(dataPoints: dataPoints, closePath: true)
                        .fill(gradient)
                        .frame(minHeight: style.lineMinHeight)
                        .background(grid)
                }

                if style.showAxis {
                    AxisView(dataPoints: dataPoints)
                        .accessibilityHidden(true)
                        .padding(.leading, style.axisLeadingPadding)
                }
            }

            if style.showLabels {
                LabelsView(dataPoints: dataPoints, labelCount: style.labelCount ?? dataPoints.count)
                    .accessibilityHidden(true)
            }

            if style.showLegends {
                LegendView(dataPoints: dataPoints)
                    .padding()
                    .accessibilityHidden(true)
            }
        }
    }
}

#if DEBUG
struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            LineChartView(dataPoints: DataPoint.mock)
            LineChartView(dataPoints: DataPoint.mock)
        }.chartStyle(LineChartStyle(showAxis: false, showLabels: false))
    }
}
#endif
