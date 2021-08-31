//
//  File.swift
//  
//
//  Created by Majid Jabrayilov on 08.12.20.
//
//  RayWo, 30.08.2021
//
import SwiftUI

/// Protocol type that defines general chart styling options
public protocol ChartStyle {  
  /// Boolean value indicating whenever show chart legends
  var showLegends: Bool { get }
 
  /// The style to be used for drawing the chart’s grid
  var gridStyle: GridStyle { get }
}

struct ChartStyleEnvironmentKey: EnvironmentKey {
  static var defaultValue: ChartStyle?
}

extension EnvironmentValues {
  var chartStyle: ChartStyle? {
    get { self[ChartStyleEnvironmentKey.self] }
    set { self[ChartStyleEnvironmentKey.self] = newValue }
  }
}

extension View {
  public func chartStyle(_ style: ChartStyle) -> some View {
    environment(\.chartStyle, style)
  }
}
