//
//  StackedHorizontalBarChartView.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 05.05.22.
//
import SwiftUI

/// Type that defines horizontally stacked bar chart style.
public struct StackedHorizontalBarChartStyle: ChartStyle {
    /// Boolean value indicating whenever to show chart legend
    public let showLegends: Bool
    /// Spacing between stacked horizontal bars
    public let spacing: CGFloat
    /// Corner radius for the whole chart view
    public let cornerRadius: CGFloat

    /**
     Creates a new stacked bar chart style with the following parameters.

     - Parameters:
        - showLegends: Bool value that controls whenever to show the legend.
        - cornerRadius: Corner radius used to round chart corners.
        - spacing: Spacing between stacked bars in the chart.
     */
    public init(
        showLegends: Bool = true,
        cornerRadius: CGFloat = 8,
        spacing: CGFloat = 0
    ) {
        self.showLegends = showLegends
        self.cornerRadius = cornerRadius
        self.spacing = spacing
    }
}

/// SwiftUI view that draws data points as horizontally stacked bars.
public struct StackedHorizontalBarChartView: View {
    /// An array of data points to draw
    let dataPoints: [DataPoint]

    @Environment(\.chartStyle) private var chartStyle
    private var style: StackedHorizontalBarChartStyle {
        (chartStyle as? StackedHorizontalBarChartStyle) ?? .init()
    }

    /**
     Creates a new horizontally stacked bar chart view

     - Parameters:
        - dataPoints: An array of data points to draw
    */
    public init(dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
    }

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: style.spacing) {
                    ForEach(dataPoints, id: \.self) { dataPoint in
                        Rectangle()
                            .fill(dataPoint.legend.color)
                            .frame(width: dataPoint.endValue / sum * geometry.size.width)
                            .accessibilityValue(Text(String(dataPoint.endValue)) + Text(dataPoint.label))
                            .accessibilityLabel(dataPoint.legend.label)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            }

            if style.showLegends {
                LegendView(dataPoints: dataPoints)
                    .padding(.top)
                    .accessibility(hidden: true)
            }
        }
    }

    private var sum: CGFloat {
        dataPoints.map(\.endValue).reduce(0.0, +)
    }
}

struct StackedHorizontalBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        let protein = Legend(color: .green, label: "Protein", order: 1)
        let carbs = Legend(color: .blue, label: "Carbs", order: 2)
        let fat = Legend(color: .red, label: "Fat", order: 3)

        return List {
            StackedHorizontalBarChartView(
                dataPoints: [
                    .init(value: 44, label: "Breast", legend: protein),
                    .init(value: 77, label: "Couscous", legend: carbs),
                    .init(value: 6, label: "Fats", legend: fat)
                ]
            )
            .frame(minHeight: 100)
            .padding(.vertical)
        }
    }
}
