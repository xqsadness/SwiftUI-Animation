//
//  TabbarAnimation.swift
//  L-Swift
//
//  Created by darktech4 on 02/10/2023.
//

import SwiftUI

struct Tabbar: Identifiable{
    var id = UUID()
    var iconName: String
    var tab: TabbarIcon
    var index: Int
}

enum TabbarIcon: String{
    case Home
    case Card
    case Favorite
    case Purchases
    case Notification
}

let tabItems = [Tabbar(iconName: "square.stack", tab: .Card, index: 0),
                Tabbar(iconName: "magnifyingglass", tab: .Favorite, index: 1),
                Tabbar(iconName: "house", tab: .Home, index: 2),
                Tabbar(iconName: "star", tab: .Purchases, index: 3),
                Tabbar(iconName: "person", tab: .Notification, index: 4)]

struct TabbarAnimation: View {
    @State var progress: CGFloat = 0.5
    @State var selectedTab: TabbarIcon = .Home
    @State var xOffset = 2 * 70.0
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(tabItems) { item in
                    Spacer()
                    Image(systemName: item.iconName)
                        .foregroundColor(.black)
                        .onTapGesture {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation() {
                                    selectedTab = item.tab
                                    xOffset = CGFloat(item.index) * 70.0
                                }
                            }
                            withAnimation {
                                progress = 0.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                withAnimation() {
                                    progress = 0.5
                                }
                            }
                        }
                    Spacer()
                }
                .frame(width: 23.3, height: 23)
            }
            .frame(maxWidth: geometry.size.width - 77)
            .frame(height: 73)
            .background(.ultraThickMaterial)
            .cornerRadius(20)
            .overlay(alignment: .topLeading) {
                CircleAnimation(circleA: $progress)
                    .offset(x: 16.3, y: 17)
                    .offset(x: xOffset)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct TabbarAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TabbarAnimation()
    }
}


struct CircleAnimation: View {
    @Binding var circleA: CGFloat
    
    var body: some View {
        VStack{
            Button{
                withAnimation(.easeInOut(duration: 2.0)) {
                    circleA = circleA == 0.0 ? 0.5 : 0.0
                }
            }label: {
                ZStack{
                    Circle()
                        .trim(from: 0.0, to: circleA)
                        .stroke(lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(-90))
                    Circle()
                        .frame(width: 4, height: 4)
                        .offset(y: -20)
                }
            }
            
            Button{
                withAnimation(.easeInOut(duration: 2.0)) {
                    circleA = circleA == 0.0 ? 0.5 : 0.0
                }
            }label: {
                ZStack{
                    Circle()
                        .trim(from: 0.0, to: circleA)
                        .stroke(lineWidth: 4)
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(90))
                    Circle()
                        .frame(width: 4, height: 4)
                        .offset(y: 20)
                }
            }
            .offset(y: -48)
        }
        .foregroundColor(.black)
    }
}
