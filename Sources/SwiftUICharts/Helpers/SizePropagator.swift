//
//  File.swift
//  File
//
//  Created by Ray Wojciechowski on 07.09.21.
//

import Foundation
import SwiftUI

struct SizePreferenceData: Equatable {
  let id: AnyHashable
  let size: CGSize
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = SizePreferenceData
  
  static var defaultValue: SizePreferenceData = .init(id: UUID(),
                                                      size: .zero)
  
  static func reduce(value: inout SizePreferenceData,
                     nextValue: () -> SizePreferenceData) {
    value = nextValue()
  }
}

struct SizePropagator<ID: Hashable, V: View>: View {
  var id: ID
  var content: V
  
  var body: some View {
    content
      .preference(key: SizePreferenceKey.self,
                  value: SizePreferenceData(id: AnyHashable(id),
                                            size: content.intrinsicSize))
  }
}


extension View {
  public var intrinsicSize: CGSize {
    UIHostingController(rootView: self).view.intrinsicContentSize
  }
}
