//
//  BarChartDelegate.swift
//  SwiftUICharts
//
//  Created by Ray Wojciechowski on 31.08.21.
//

import Foundation

public protocol BarChartDelegate {
  associatedtype BaseData: Hashable
  
  func barChart(didSelectBar dataPoint: DataPoint<BaseData>)
}

struct DefaultBarChartDelegate: BarChartDelegate {
  typealias BaseData = Int
  
  func barChart(didSelectBar dataPoint: DataPoint<Int>) { }
}
