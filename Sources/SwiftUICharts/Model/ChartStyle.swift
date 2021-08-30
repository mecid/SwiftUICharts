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
  /// Boolean value indicating whenever show chart labels
  var showLabels: Bool { get }
  
  /// Boolean value indicating whenever show chart axis
  var showAxis: Bool { get }
  
  /// Leading padding for the value axis displayed in the chart
  var axisLeadingPadding: CGFloat { get }
  
  /// Boolean value indicating whenever show chart legends
  var showLegends: Bool { get }
  
  /// The number of grid lines to be shown (including min and max lines)
  var gridLines: Int { get }
  
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
