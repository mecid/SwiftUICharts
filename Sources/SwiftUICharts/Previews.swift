//
//  Previews.swift
//  SwiftUICharts
//
//  Created by Majid Jabrayilov on 31.05.22.
//
import SwiftUI

#if DEBUG
struct Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(dataPoints: DataPoint.mock)
            .chartStyle(
                BarChartStyle(
                    barMinHeight: 100,
                    showAxis: true,
                    axisLeadingPadding: 0,
                    showLabels: true,
                    labelCount: 5,
                    showLegends: true
                )
            )
        
        BarChartView(
            dataPoints: DataPoint.mock.map {
                DataPoint(
                    startValue: Double.random(in: 0..<$0.endValue),
                    endValue: $0.endValue,
                    label: $0.label,
                    legend: $0.legend
                )
            }
        )
        .chartStyle(BarChartStyle(showLabels: false))
        
        HStack {
            BarChartView(
                dataPoints: Array(DataPoint.mock[0...10]),
                limit: DataPoint.mock[0]
            )
            BarChartView(
                dataPoints: Array(DataPoint.mock[11...20]),
                limit: DataPoint.mock[1]
            )
        }
        .chartStyle(BarChartStyle(showAxis: false, showLabels: false, showLegends: false))

        BarChartView(dataPoints: DataPoint.mock, limit: DataPoint.mock[3])
            .chartStyle(
                BarChartStyle(
                    barMinHeight: 100,
                    showAxis: true,
                    axisLeadingPadding: 0,
                    showLabels: true,
                    labelCount: 5,
                    showLegends: true
                )
            )
        
        StackedHorizontalBarChartView(
            dataPoints: Array(DataPoint.mock[0...7])
        )
        .frame(maxHeight: 80)
        .padding()
        .chartStyle(
            StackedHorizontalBarChartStyle(
                showLegends: true,
                cornerRadius: 8,
                spacing: 0
            )
        )
        
        HorizontalBarChartView(
            dataPoints: DataPoint.mock,
            barMaxWidth: 200
        )
        
        LineChartView(dataPoints: DataPoint.mock)
            .chartStyle(
                LineChartStyle(
                    lineMinHeight: 100,
                    showAxis: true,
                    axisLeadingPadding: 0,
                    showLabels: true,
                    labelCount: 10,
                    showLegends: true,
                    drawing: .fill
                )
            )
        
        LineChartView(dataPoints: DataPoint.mock)
            .chartStyle(
                LineChartStyle(
                    lineMinHeight: 100,
                    showAxis: true,
                    axisLeadingPadding: 0,
                    showLabels: true,
                    labelCount: 10,
                    showLegends: true,
                    drawing: .stroke(width: 4)
                )
            )
        
    }
}
#endif
