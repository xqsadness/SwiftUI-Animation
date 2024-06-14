//
//  ContentView.swift
//  L-Swift
//
//  Created by xqsadness on 02/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State var show = true
    @State var searchText = ""
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                VStack(spacing: 15) {
                    navigationScreen("Compositional") {
                        HomeCompositional()
                    }
                    
                    navigationScreen("Particle Effects") {
                        ParticleEffectsHome()
                    }
                    
                    navigationScreen("Tab bar") {
                        HomeTabbar2View()
                    }
                    
                    navigationScreen("Side Menu") {
                        SideMenuView(show: $show)
                    }
                    
                    navigationScreen("Onboarding") {
                        OnboardingView()
                    }
                    
                    navigationScreen("Onboarding 2") {
                        HomeOnBoarding2()
                    }
                    
                    navigationScreen("Movable Grids") {
                        MovableGrids()
                    }
                    
                    navigationScreen("Arc Menu Button") {
                        ArcMenuButton(buttons: Array(ArcMenuButtonName.allCases)) { button in
                            switch button {
                            case .capture:
                                print("Capture button tapped.")
                            case .star:
                                print("star button tapped.")
                            case .noti:
                                print("noti button tapped.")
                            case .bookmark:
                                print("bookmark button tapped.")
                            }
                        }
                    }
                    
                    navigationScreen("Password Strength") {
                        PasswordStrength()
                    }
                    
                    navigationScreen("Custom Search bar") {
                        CustomSearchbar(searchText: $searchText)
                    }
                    
                    navigationScreen("Bubble Transition") {
                        BubbleTransition()
                    }
                    
                    navigationScreen("Segment Animated") {
                        SegmentAnimatedView()
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func navigationScreen<Content: View>(_ title: String, @ViewBuilder content: @escaping () -> Content) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text("\(title)")
                    .font(.title3)
                    .foregroundStyle(Color.text)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundStyle(Color.text)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
