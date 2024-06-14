//
//  HomeTabbar2View.swift
//  L-Swift
//
//  Created by xqsadness on 12/10/2023.
//

import SwiftUI

struct HomeTabbar2View: View {
    @State private var activeTab: Tab = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    init(){
        ///Hiding tab bar due to swiftui ios 16 bug
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $activeTab) {
                Text("Home")
                    .tag(Tab.home)
                ///hiding native tab bar
                //                    .toolbar(.hidden, for: .tabBar)
                
                Text("Service")
                    .tag(Tab.services)
                ///hiding native tab bar
                //                    .toolbar(.hidden, for: .tabBar)
                
                Text("Partners")
                    .tag(Tab.partners)
                ///hiding native tab bar
                //                    .toolbar(.hidden, for: .tabBar)
                
                Text("Activity")
                    .tag(Tab.activity)
                ///hiding native tab bar
                //                    .toolbar(.hidden, for: .tabBar)
            }
            
            CustomTabbar()
        }
    }
    
    ///Custom tab bar
    ///With more easy customization
    @ViewBuilder
    func CustomTabbar(_ tint: Color = Color("Blue"), _ inactiveTint: Color = .blue) -> some View{
        HStack(alignment: .bottom,spacing: 0){
            ForEach(Tab.allCases, id: \.rawValue){
                TabItem(tint: tint, inativeTint: inactiveTint, tab: $0,animation: animation ,activeTab: $activeTab, position: $tabShapePosition)
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical,10)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
            ///Adding blur + shadow
            ///for shape smoothening
                .shadow(color: tint.opacity(0.2), radius: 5,x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View{
    var tint: Color
    var inativeTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    @State private var tabPosition: CGPoint = .zero
    var body: some View{
        VStack(spacing: 5){
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inativeTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab{
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .hAlign(.center)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            /// updating active tab position
            if activeTab == tab{
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                position.x = tabPosition.x
            }
        }
    }
}

struct HomeTabbar2View_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabbar2View()
    }
}
