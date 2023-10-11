//
//  FirstView.swift
//  L-Swift
//
//  Created by darktech4 on 06/10/2023.
//

import SwiftUI

struct FirstView: View {
    @Binding var showNextView: Bool
    @State var isExpanded = false
    @State var startTyping = false
    @State var showText = false
    var body: some View {
        ZStack{
            GeoView(isExpanded: $isExpanded, startTyping: $startTyping, showText: $showText, color: "fview", showNextView: $showNextView)
            
            VStack(alignment: .leading){
                Text("Swiftui \nFramework").font(.system(size: 50)).bold()
                
                TypingEffectView(fullText: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry.

Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,

 when an unknown printer took a galley of type and scrambled it to make a type
""", isExpanded: $startTyping)
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(showNextView: .constant(false))
    }
}

struct GeoView: View {
    @Binding var isExpanded: Bool
    @Binding var startTyping: Bool
    @Binding var showText: Bool
    
    var color: String
    var text: String = "NEXT"
    var showNextView: Binding<Bool>?
    var showToogleExpand: Bool = true
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Circle().foregroundColor(Color("\(color)"))
                    .frame(width: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200, height: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200)
                if !isExpanded{
                    HStack{
                        Text(text)
                        Image(systemName: "arrow.right")
                    }
                    .bold().font(.system(size: 20))
                    .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .offset(x: isExpanded ? -250 : 40, y: isExpanded ? -150 : 20)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) {
                if showToogleExpand{
                    isExpanded.toggle()
                }else{
                    isExpanded = true
                }
                
                showText.toggle()
                startTyping = true
                
                if let showNextViewBinding = showNextView{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showNextViewBinding.wrappedValue.toggle()
                    }
                }
            }
        }
    }
}
