//
//  CustomSearchbar.swift
//  L-Swift
//
//  Created by xqsadness on 14/10/2023.
//

import SwiftUI

struct CustomSearchbar: View {
    @Binding var searchText : String
    @State var iconOffset = false
    @State var state = false
    @State var progress: CGFloat = 1.0
    @State var showTextFi = false
    
    var body: some View {
        ZStack(alignment: .trailing){
            ZStack{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 1.5)
                    .foregroundColor(Color.gray)
                if showTextFi{
                    TextField("", text: $searchText)
                        .placeholder(when: searchText.isEmpty) {
                            Text("Search").foregroundColor(.text.opacity(0.4))
                        }
                        .padding(.horizontal)
                        .foregroundColor(.text) .foregroundColor(.text)
                        .padding(.trailing, 22)
                    
                }
            }
            .frame(width: state ? 350 : 35, height: 35)
            .foregroundColor(Color.white)
            
            CustomIcon(searchText: $searchText,progress: $progress, iconOffset: $iconOffset, stete: $state, showTextFi: $showTextFi)
        }
        .padding(.horizontal)
        .hAlign(.trailing)
        .vAlign(.top)
    }
}

struct CustomIcon: View{
    @Binding var searchText : String
    @Binding var progress : CGFloat
    @Binding var iconOffset: Bool
    @Binding var stete: Bool
    @Binding var showTextFi: Bool
    var body: some View{
        Button {
            if showTextFi{
                showTextFi = false
                searchText = ""
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation {
                    if !showTextFi && stete{
                        showTextFi = true
                    }
                }
            }
            
            withAnimation {
                stete.toggle()
            }
            
            if progress == 1.0{
                withAnimation(.linear(duration: 0.5)) {
                    progress = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    withAnimation(.linear(duration: 0.3)) {
                        iconOffset.toggle()
                    }
                }
            }else{
                withAnimation {
                    iconOffset.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                    withAnimation(.linear(duration: 0.5)) {
                        progress = 1.0
                    }
                }
            }
        } label: {
            VStack{
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(lineWidth: 3)
                    .rotationEffect(.degrees(88))
                    .frame(width: 9, height: 9)
                    .padding()
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 3, height: iconOffset ? 20 : 15)
                    .offset(y: -20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: iconOffset ? 20 : 15)
                            .rotationEffect(.degrees( iconOffset ? 80 : 0), anchor: .center)
                            .offset(y: -20)
                            
                    }
                    .padding(.top,iconOffset ? -9 : 0)
            }
        }
        .offset(x: iconOffset ? -5 : 2, y: iconOffset ? -5 : 5)
        .rotationEffect(.degrees(-40))
        .foregroundColor(Color.text)
        .frame(width: 40, height: 40)
    }
}

struct CustomSearchbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchbar(searchText: .constant("123123"))
    }
}
