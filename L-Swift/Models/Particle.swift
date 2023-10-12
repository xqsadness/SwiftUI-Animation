//
//  Particle.swift
//  L-Swift
//
//  Created by darktech4 on 12/10/2023.
//

import SwiftUI

struct Particale: Identifiable{
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    //optional
    var opacity: CGFloat = 1
    
    //reset all props
    mutating func reset(){
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 1
    }
}

