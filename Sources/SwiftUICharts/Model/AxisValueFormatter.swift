//
//  AxisValueFormatter.swift
//  SwiftUIChartsDev
//
//  Created by alex on 02.07.2021.
//

import SwiftUI

public typealias AxisValueFormatter = ((Double) -> String)

struct AxisValueFormatterEnvironmentKey: EnvironmentKey {
    static var defaultValue: AxisValueFormatter?
}

extension EnvironmentValues {
    var axisValueFormatter: AxisValueFormatter? {
        get { self[AxisValueFormatterEnvironmentKey.self] }
        set { self[AxisValueFormatterEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func axisValueFormatter(_ formatter: @escaping AxisValueFormatter) -> some View {
        environment(\.axisValueFormatter, formatter)
    }
}
