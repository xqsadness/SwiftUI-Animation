//
//  TabPosition.swift
//  L-Swift
//
//  Created by darktech4 on 12/10/2023.
//

import SwiftUI


/// Custom View Extension
/// Which will Return View Position
struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition (completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange (PositionKey.self, perform: completion)
                }
            }
        
    }
}
