//
//  PageIntro.swift
//  L-Swift
//
//  Created by xqsadness on 11/10/2023.
//

import SwiftUI

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introAssetImage: String
    var title: String
    var subTitle: String
    var displayAction: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introAssetImage: "page 1", title: "Connect With\nCreators Easily", subTitle: "Thank you for choosing us, we can save your lovely time."),
    .init(introAssetImage: "page 2", title: "Get Inspiration\nFrom Creators", subTitle: "Find your favourite creator and get inspired by them."),
    .init(introAssetImage: "page 2", title: "Let's\nGet Started", subTitle: "To register for an account, kindly enter yourdetails.", displayAction: true),
]

