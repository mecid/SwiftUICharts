//
//  ChartDataPointSelector.swift
//  SwiftUIChartsDev
//
//  Created by alex on 01.07.2021.
//

import SwiftUI

public typealias ChartDataPointSelector = ((DataPoint) -> Void)

struct ChartDataPointSelectorEnvironmentKey: EnvironmentKey {
    static var defaultValue: ChartDataPointSelector?
}

extension EnvironmentValues {
    var chartDataPointSelector: ChartDataPointSelector? {
        get { self[ChartDataPointSelectorEnvironmentKey.self] }
        set { self[ChartDataPointSelectorEnvironmentKey.self] = newValue }
    }
}

extension View {
    public func chartDataPointSelector(_ selector: @escaping ChartDataPointSelector) -> some View {
        environment(\.chartDataPointSelector, selector)
    }
}
