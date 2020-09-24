//
//  File.swift
//  
//
//  Created by Majid Jabrayilov on 20.07.20.
//
import Foundation

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
