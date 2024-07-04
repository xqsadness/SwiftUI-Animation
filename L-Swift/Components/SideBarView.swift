//
//  SideBarView.swift
//  L-Swift
//
//  Created by xqsadness on 15/06/2024.
//

import SwiftUI

enum Tab2: String, CaseIterable {
    case home = "Home"
    case table = "Table"
    case menu = "Menu"
    case order = "Order"
    case history = "History"
    case report = "Report"
    case alert = "Alert"
    case settings = "Settings"
}

struct SideBarView: View {
    @State private var currentTab: Tab2 = .home
    @State private var showSidebar: Bool = false
    @Namespace var animation

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "square.grid.2x2.fill")
                .imageScale(.large)
                .onTapGesture {
                    withAnimation { showSidebar.toggle() }
                }
                .padding()
                .hAlign(.leading)
            
            TabView(selection: $currentTab) {
                ForEach(Tab2.allCases, id: \.self) { tab in
                    Text(tab.rawValue)
                        .tag(tab)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background {
            Color.black
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .overlay(alignment: .leading) {
            ViewThatFits {
                SideBar()
                ScrollView {
                    SideBar()
                }
                .scrollIndicators(.hidden)
                .background(Color.white).ignoresSafeArea()
            }
            .offset(x: showSidebar ? 0 : -100)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Color.black
                    .opacity(showSidebar ? 0.25 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showSidebar.toggle() }
                    }
            }
        }
    }

    @ViewBuilder
    func SideBar() -> some View {
        VStack(spacing: 10) {
            Image("placeholder_image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .padding(.bottom, 10)
            
            ForEach(Tab2.allCases, id: \.self) { tab in
                VStack(spacing: 8) {
                    Image(systemName: "xbox.logo")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    
                    Text(tab.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(currentTab == tab ? Color.orange : .gray)
                .padding(.vertical, 13)
                .frame(width: 65)
                .background {
                    if currentTab == tab {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.orange).opacity(0.1)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        currentTab = tab
                    }
                }
            }
            
            Button {
                
            } label: {
                VStack {
                    Image("placeholder_image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    
                    Text("Profile")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.top, 10)
        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: 100)
        .background(
            Color.white.ignoresSafeArea()
        )
    }
}

#Preview {
    SideBarView()
}
