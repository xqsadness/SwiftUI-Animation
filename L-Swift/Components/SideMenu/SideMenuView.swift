//
//  SideMenuView.swift
//  L-Swift
//
//  Created by xqsadness on 02/10/2023.
//

import SwiftUI

class SidebarState: ObservableObject {
    @Published var isSideBarOpened = false
}

struct sideBar: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var tab: TabIcon
    var index: Int
}
let sidebar = [
    sideBar (icon: "house.fill", title: "Home", tab: .Home, index: 0),
    sideBar (icon: "creditcard.fill", title: "Card", tab: .Card, index: 1),
    sideBar(icon: "heart.fill", title: "Favorite", tab: .Favorite, index: 2),
    sideBar(icon: "cart.fill", title: "Purchases", tab: .Purchases, index: 3),
    sideBar(icon: "bell.badge.fill", title: "Notification", tab: .Notification, index: 4),
]
enum TabIcon :String {
    case Home
    case Card
    case Favorite
    case Purchases
    case Notification
}

struct SideMenuView: View {
    @State var selectedItem:TabIcon = .Home
    @State var yOffset:CGFloat = 0
    @Binding var show: Bool
    let minDrag: CGFloat = 100
    
    var body: some View {
        VStack{
            //sideMenu
            HStack(spacing: 0){
                HStack{
                    content
                        .offset(x: show ? 0 : -270)
                        .gesture(
                            DragGesture()
                                .onEnded({ value in
                                    let shouldShow = value.translation.width > self.minDrag
                                    withAnimation {
                                        show = shouldShow
                                    }
                                })
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack{ }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            show = false
                        }
                    }
            }
        }
    }
    
    var content: some View {
        ZStack{
            Color("sideBG")
                .frame(width: 266)
                .mask(RoundedRectangle (cornerRadius: 10, style:
                        .continuous))
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    UserInfoView()
                    
                    TabSideview(selecteditem: $selectedItem, yOffset: $yOffset)
                }
                .padding(.leading,15)
                
                DividerSide()
                
                TabviewV()
                
                HStack{
                    Text("Learn more about the app ")
                        .padding(.leading)
                    Image(systemName: "questionmark.circle")
                }
                .foregroundColor(.white)
                .padding(.top,5)
                
                Spacer()
                
                HStack{
                    Bicon(icon: "moon.zzz.fill")
                    Spacer()
                    Text("Shpoing")
                        .foregroundColor(.white)
                    Spacer()
                    Bicon(icon: "gearshape.fill")
                }
                .padding(.bottom,20)
                .frame(width: 230,height: 90)
                .padding(.leading,17)
            }
        }
        .ignoresSafeArea()
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    @StateObject var sidebarState: SidebarState = .init()
    static var previews: some View {
        SideMenuView(show: .constant(true))
    }
}

struct UserInfoView: View {
    var body: some View {
        HStack{
            Circle()
                .frame(width: 65, height: 65)
            VStack (alignment: .leading, spacing: 4){
                RoundedRectangle(cornerRadius: 3, style:
                        .continuous)
                .frame(width: 100, height: 14)
                RoundedRectangle (cornerRadius: 3, style:
                        .continuous)
                .frame (width: 80, height: 7)
                .opacity (0.5)
                RoundedRectangle (cornerRadius: 3, style:
                        .continuous)
                .frame(width: 52, height: 7)
                .opacity (0.5)
            }
        }
        .foregroundColor(.white)
        .padding(.top, 60)
    }
}

struct TabSideview: View {
    @Binding var selecteditem: TabIcon
    @Binding var yOffset:CGFloat
    @State var isAnimation = false
    
    var body: some View {
        ZStack (alignment: .leading) {
            Rectangle()
                .frame(width: isAnimation ? 7 : 230, height: 45)
                .foregroundColor(Color("se"))
                .cornerRadius (7)
                .offset(y: yOffset)
                .padding(.vertical, 8)
                .padding(. horizontal, 5)
                .offset(y: -125)
                .offset(x: -20)
                .animation(.default, value: isAnimation)
            VStack (spacing: 0) {
                ForEach(sidebar) { item in
                    Button {
                        withAnimation {
                            isAnimation = true
                        }
                        DispatchQueue.main.asyncAfter (deadline: .now() + 0.3) {
                            withAnimation {
                                selecteditem = item.tab
                                yOffset = CGFloat(item.index) * 70
                            }
                        }
                        DispatchQueue.main.asyncAfter (deadline: .now() + 0.6){
                            withAnimation {
                                isAnimation = false
                            }
                        }
                    } label: {
                        HStack{
                            ZStack{
                                Circle()
                                    .frame(width: 39, height: 40)
                                    .foregroundStyle(.ultraThinMaterial)
                                Image(systemName: item.icon)
                                    . foregroundColor(.white)
                            }
                            Text(item.title).bold()
                                .font (.title3)
                                .foregroundColor(.white)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .padding(.top,30)
                    }
                }
            }
            .frame(width: 246, height: 330)
        }
    }
}

struct DividerSide: View {
    var body: some View {
        Rectangle ().frame(width: 266, height: 1)
            .foregroundColor(.gray.opacity (0.4))
            .padding(.top,30)
    }
}

struct Bicon: View {
    var icon = ""
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(.ultraThinMaterial)
            Image(systemName: icon)
                .foregroundColor(.white)
        }
    }
}
