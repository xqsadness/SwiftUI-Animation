//
//  DataTabbarModel.swift
//  L-Swift
//
//  Created by xqsadness on 17/06/2024.
//

import SwiftUI

struct TabbarLightModel: Identifiable {
    var id = UUID()
    var iconName: String
    var tab: TabbarLightIcon
    var index: Int
}

let tabLightItems = [
    TabbarLightModel(iconName: "house", tab: .Discovery, index: 0),
    TabbarLightModel(iconName: "star", tab: .Playlists, index: 1),
    TabbarLightModel(iconName: "square.stack", tab: .Files, index: 2),
    TabbarLightModel(iconName: "person", tab: .Setting, index: 3)
]

enum TabbarLightIcon: String{
    case Discovery
    case Playlists
    case Files
    case Setting
}
