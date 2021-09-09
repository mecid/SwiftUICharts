//
//  DataPoint.swift
//  CardioBot
//
//  Created by Majid Jabrayilov on 5/13/20.
//  Copyright © 2020 Majid Jabrayilov. All rights reserved.
//
//  RayWo 29.08.2021
//
import SwiftUI


/// The type that describes a data point in the chart.
public struct DataPoint<BaseData>: Identifiable {
  public let id: UUID = UUID()  
  
  /// Starting point of a bar (used only in the ``BarChartView``)
  public let startValue: Double
  
  /// Double value representing the data point
  public let endValue: Double
  
  /// LocalizedStringKey representing the data point
  public let label: LocalizedStringKey
  
  /// ``Legend`` value representing the data point
  public let legend: Legend
  
  /// Boolean value controlling the visibility of the data point in the chart
  public let visible: Bool
  
  /// The data this point is based upon. Can be queried when returned via the
  /// delegate’s ``barChart(didSelectBar)`` method.
  public var dataObject: BaseData?
  
  
  /// Creates new data point with the following parameters.
  /// - Parameters:
  ///   - value: Double that represents a value of the point in the chart.
  ///   - label: LocalizedStringKey that describes the point.
  ///   - legend: The legend of data point, usually appears below the chart.
  ///   - visible: The boolean that controls the visibility of the data point
  ///              in the chart. Default value is true.
  ///   - dataObject: The data this point is based upon. Can be queried when
  ///                 returned via the delegate’s ``barChart(didSelectBar)``
  ///                 method.
  public init(value: Double,
              label: LocalizedStringKey,
              legend: Legend,
              visible: Bool = true,
              dataObject: BaseData? = nil) {
    self.startValue = 0
    self.endValue = value
    self.label = label
    self.legend = legend
    self.visible = visible
    self.dataObject = dataObject
  }
  
  
  /// Creates new data point with the following parameters.
  /// - Parameters:
  ///   - startValue: Double that represents a start value of the point in
  ///                 the chart.
  ///   - endValue: Double that represents an end value of the point in
  ///               the chart.
  ///   - label: LocalizedStringKey that describes the point.
  ///   - legend: The legend of data point, usually appears below the chart.
  ///   - visible: The boolean that controls the visibility of the data point
  ///              in the chart. Default value is true.
  ///   - dataObject: The data this point is based upon. Can be queried when
  ///                 returned via the delegate’s ``barChart(didSelectBar)``
  ///                 method.
  public init(startValue: Double,
              endValue: Double,
              label: LocalizedStringKey,
              legend: Legend,
              visible: Bool = true,
              dataObject: BaseData? = nil) {
    self.startValue = startValue
    self.endValue = endValue
    self.label = label
    self.legend = legend
    self.visible = visible
    self.dataObject = dataObject
  }
  
}

extension DataPoint: Equatable {
  
  public static func == (lhs: DataPoint<BaseData>, rhs: DataPoint<BaseData>) -> Bool {
    lhs.id == rhs.id
  }
  
}

extension DataPoint: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(legend)
    hasher.combine(startValue)
    hasher.combine(endValue)
  }
}

extension DataPoint: Comparable {
  public static func < (lhs: DataPoint, rhs: DataPoint) -> Bool {
    lhs.endValue < rhs.endValue
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
  
  static var mockFewData: [DataPoint] {
    let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
    let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
    let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
    let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
    let low = Legend(color: .gray, label: "Low", order: 1)
    
    return [
      .init(value: 45, label: "1", legend: low),
      .init(value: 90, label: "2", legend: warmUp),
      .init(value: 103.9, label: "3", legend: fatBurning),
      .init(value: 92, label: "4", legend: buildFitness),
      .init(value: 78, label: "5", legend: highIntensity),
    ]
  }
  
  static var mockLimit: DataPoint {
    let legend = Legend(color: .pink, label: "average")
    
    let values = mockFewData.map { $0.endValue }
    let avg = values.reduce(0.0, +) / Double(values.count)
    
    return DataPoint(value: avg, label: "avg: \(avg)", legend: legend)
  }
}
#endif
