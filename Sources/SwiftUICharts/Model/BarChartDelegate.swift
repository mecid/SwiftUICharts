//
//  BarChartDelegate.swift
//  SwiftUICharts
//
//  Created by Ray Wojciechowski on 31.08.21.
//

import Foundation

public protocol BarChartDelegate {
  associatedtype BaseData
  
  func barChart(didSelectBar dataPoint: DataPoint<BaseData>)
}

public struct DefaultBarChartDelegate: BarChartDelegate {
  public typealias BaseData = Int
  
  public func barChart(didSelectBar dataPoint: DataPoint<Int>) { }
}
