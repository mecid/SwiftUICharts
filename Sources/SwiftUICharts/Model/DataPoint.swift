//
//  DataPoint.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 5/13/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
import SwiftUI

/// The type that describes the group of data points in the chart.
public struct Legend {
    let color: Color
    let label: LocalizedStringKey
    let order: Int

    /**
     Creates new legend with the following parameters.

     - Parameters:
        - color: The color of the group that will be used to draw data points.
        - label: LocalizedStringKey that describes the legend.
        - order: The number that will be used to sort chart legends list. Default value is 0.
     */
    public init(color: Color, label: LocalizedStringKey, order: Int = 0) {
        self.color = color
        self.label = label
        self.order = order
    }
}

extension Legend: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.order < rhs.order
    }
}

extension Legend: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
    }
}

/// The type that describes a data point in the chart.
public struct DataPoint {
    public let value: Double
    public let label: LocalizedStringKey
    public let legend: Legend
    public let visible: Bool

    /**
     Creates new data point with the following parameters.

     - Parameters:
        - value: Double that represents a value of the point in the chart.
        - label: LocalizedStringKey that describes the point.
        - legend: The legend of data point, usually appears below the chart.
        - visible: The boolean that controls the visibility of the data point in the chart. Default value is true.
     */
    public init(value: Double, label: LocalizedStringKey, legend: Legend, visible: Bool = true) {
        self.value = value
        self.label = label
        self.legend = legend
        self.visible = visible
    }
}

extension DataPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(legend)
        hasher.combine(value)
    }
}

extension DataPoint: Comparable {
    public static func < (lhs: DataPoint, rhs: DataPoint) -> Bool {
        lhs.value < rhs.value
    }
}

#if DEBUG
extension DataPoint {
    static var mock: [DataPoint] {
        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
        let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
        let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)

        return [
            .init(value: 70, label: "1", legend: low),
            .init(value: 90, label: "2", legend: warmUp),
            .init(value: 91, label: "3", legend: warmUp),
            .init(value: 92, label: "4", legend: warmUp),
            .init(value: 130, label: "5", legend: fatBurning),
            .init(value: 124, label: "6", legend: fatBurning),
            .init(value: 135, label: "7", legend: fatBurning),
            .init(value: 133, label: "8", legend: fatBurning),
            .init(value: 136, label: "9", legend: fatBurning),
            .init(value: 138, label: "10", legend: fatBurning),
            .init(value: 150, label: "11", legend: buildFitness),
            .init(value: 151, label: "12", legend: buildFitness),
            .init(value: 150, label: "13", legend: buildFitness),
            .init(value: 136, label: "14", legend: fatBurning),
            .init(value: 135, label: "15", legend: fatBurning),
            .init(value: 130, label: "16", legend: fatBurning),
            .init(value: 130, label: "17", legend: fatBurning),
            .init(value: 150, label: "18", legend: buildFitness),
            .init(value: 151, label: "19", legend: buildFitness),
            .init(value: 150, label: "20", legend: buildFitness),
            .init(value: 160, label: "21", legend: highIntensity),
            .init(value: 159, label: "22", legend: highIntensity),
            .init(value: 161, label: "23", legend: highIntensity),
            .init(value: 158, label: "24", legend: highIntensity),
        ]
    }
}
#endif
