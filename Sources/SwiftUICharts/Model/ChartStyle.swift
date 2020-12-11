//
//  File.swift
//  
//
//  Created by Majid Jabrayilov on 08.12.20.
//
import SwiftUI

public protocol ChartStyle {
    var showLabels: Bool { get }
    var showAxis: Bool { get }
    var showLegends: Bool { get }
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
