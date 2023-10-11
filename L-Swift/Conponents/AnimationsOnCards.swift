//
//  AnimationsOnCards.swift
//  L-Swift
//
//  Created by darktech4 on 02/10/2023.
//

import SwiftUI

struct AnimationsOnCards: View {
    @State var rotation: CGFloat = 0.0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 260, height: 340)
                .foregroundColor(.black)
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 500, height: 200)
                .foregroundStyle(LinearGradient (gradient: Gradient (colors:
                                                                        [.red.opacity(0.4),.orange, .yellow, .green, .blue,.purple,.pink.opacity(0.4)]), startPoint:
                        .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 5)
                        .frame(width: 256, height: 336)
                }
            Text("Card").bold()
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .onAppear{
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}

struct AnimationsOnCards_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsOnCards()
    }
}
