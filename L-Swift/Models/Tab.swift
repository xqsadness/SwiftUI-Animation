//
//  Tab.swift
//  L-Swift
//
//  Created by darktech4 on 12/10/2023.
//

import Foundation

//app tabs

enum Tab: String, CaseIterable{
    case home = "Home"
    case services = "Service"
    case partners = "Partners"
    case activity = "Activity"

    var systemImage: String{
        switch self{
        case .home:
            return "house"
        case .services:
            return "envelope.open.badge.clock"
        case .partners:
            return "hand.raised"
        case .activity:
            return "bell"
        }
    }
    
    var index: Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
