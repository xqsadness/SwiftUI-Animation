//
//  CustomIndicatorView.swift
//  L-Swift
//
//  Created by xqsadness on 11/10/2023.
//

import SwiftUI

struct CustomIndicatorView: View {
    //view prop
    var totalPages: Int
    var currentPages: Int
    var activeInt: Color = .black
    var inActiveInt: Color = .gray.opacity(0.5)
    
    
    var body: some View {
        HStack(spacing: 8){
            ForEach(0..<totalPages, id: \.self){
                Circle()
                    .fill(currentPages == $0 ? activeInt : inActiveInt)
                    .frame(width: 4, height: 4)
            }
        }
    }
}
