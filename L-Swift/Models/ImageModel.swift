//
//  ImageModel.swift
//  L-Swift
//
//  Created by xqsadness on 13/10/2023.
//

import SwiftUI

struct ImageModel: Identifiable, Codable, Hashable {
    var id: String
    var download_url: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case download_url
    }
}
