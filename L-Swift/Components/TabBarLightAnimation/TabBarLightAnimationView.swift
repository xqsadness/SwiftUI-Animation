//
//  TabBarLightAnimationView.swift
//  L-Swift
//
//  Created by xqsadness on 17/06/2024.
//

import SwiftUI

struct TabBarLightAnimationView: View {
    
    @State private var selectedTab: TabbarLightIcon = .Discovery
    @State private var Xoffset = 0 * 70.0
    @State private var isVisible = true
    var flashing:Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    ForEach(tabLightItems){ item in
                        Spacer()
                        
//                        VStack{
                            Image(systemName: item.iconName)
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.gray.opacity(0.4))
//                            Text(item.tab.rawValue)
//                                .font(.subheadline)
//                                .lineLimit(1)
//                        }
                        
                        Spacer()
                    }
                    .frame(width: 33)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(Color.bgGray, in: .rect(cornerRadius: 24))
                .overlay(alignment: .topLeading){
                    VStack(spacing: 0){
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.bgrYellow)
                            .frame(width: 50, height: 4)
                        
                        Lightshape()
                            .frame(height: 70)
                            .opacity(isVisible ? 1 : 0)
                    }
                    .offset(x: 24, y: 0)
                    .offset(x: Xoffset)
                }
                
                HStack{
                    ForEach(tabLightItems){ item in
                        Spacer()
                        
//                        VStack{
                            Image(systemName: item.iconName)
                                .bold()
                                .font(.title2)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.bgrYellow, Color.bgrYellow.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                                .opacity(isVisible ? 1 : 0)
                                .onTapGesture {
                                    withAnimation(.spring){
                                        selectedTab = item.tab
                                        Xoffset = CGFloat(item.index) * 99
                                    }
                                    
                                    if flashing{
                                        performFlashing()
                                    }
                                }
//                            Text(item.tab.rawValue)
//                                .font(.subheadline)
//                                .lineLimit(1)
//                        }
                        
                        Spacer()
                    }
                    .frame(width: 33)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .mask {
                    VStack(spacing: 0){
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.bgrYellow)
                            .frame(width: 50, height: 4)
                        
                        Lightshape()
                            .frame(height: 70)
                    }
                    .offset(x: 24, y: 0)
                    .offset(x: Xoffset)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func performFlashing(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0){
            isVisible = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                isVisible = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    isVisible = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        isVisible = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            isVisible = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                isVisible = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TabBarLightAnimationView()
}
