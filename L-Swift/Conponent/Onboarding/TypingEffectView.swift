//
//  TypingEffectView.swift
//  L-Swift
//
//  Created by darktech4 on 09/10/2023.
//

import SwiftUI

struct TypingEffectView: View {
    @State private var displayedText = ""
    var fullText: String
    @State private var currentCharIndex: String.Index!
    @Binding var isExpanded: Bool
    var body: some View {
        VStack{
            Text(displayedText).font(.custom("Corier", size: 15))
                .foregroundColor(.black)
                .frame(width: 380, height: 150, alignment: .topLeading)
        }
        .onChange(of: isExpanded) { newValue in
            if newValue{
                startTypingEffect()
            }
        }
    }
    
    func startTypingEffect(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            currentCharIndex = fullText.startIndex
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                displayedText.append(fullText[currentCharIndex])
                currentCharIndex = fullText.index(after: currentCharIndex)
                if currentCharIndex == fullText.endIndex{
                    timer.invalidate()
                }
            }
        }
    }
}
