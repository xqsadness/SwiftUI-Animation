//
//  TabViewV.swift
//  L-Swift
//
//  Created by darktech4 on 02/10/2023.
//

import SwiftUI

struct TabviewV: View {
    @State var selctedIndex = 0
    let timer = Timer.publish (every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selctedIndex) {
            imageview(image: "m1")
                .tag(1)
            imageview(image: "m2")
                .tag(2)
            imageview(image: "m3")
                .tag(3)
            imageview(image: "m4")
                .tag(4)
            imageview(image: "m5")
                .tag(5)
        }
        .tabViewStyle(PageTabViewStyle())
        .offset(x: -10)
        .frame(width: 266,height: 175)
        .padding(.top, 10)
        .onReceive(timer){ _ in
            withAnimation {
                selctedIndex = selctedIndex == 5 ? 0 : selctedIndex + 1
            }
        }
        .onAppear{
            selctedIndex = 1
        }
    }
}

struct tabviewV_Previews: PreviewProvider {
    static var previews : some View {
        TabviewV()
    }
}

struct imageview: View {
    var image = ""
    var body: some View {
        Image (image)
            .resizable()
            .scaledToFill()
            .frame(width: 230, height: 157)
            .clipped ()
            .cornerRadius (10)
            .padding(.leading, 15)
    }
}
