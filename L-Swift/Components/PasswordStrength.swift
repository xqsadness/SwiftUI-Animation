//
//  PasswordStrength.swift
//  L-Swift
//
//  Created by xqsadness on 13/10/2023.
//

import SwiftUI

struct PasswordStrength: View {
    @State var text = ""
    @State var progress: CGFloat = 0
    @State var checkMinChars = false
    @State var checkLetter = false
    @State var checkPunctuation = false
    @State var checkNumber = false
    @State var showPassword = false
    
    var progressColor: Color{
        let containsLetters = text.rangeOfCharacter(from: .letters) != nil
        
        let containsNumbers = text.rangeOfCharacter(from: .decimalDigits) != nil
        
        let containsPunctuation = text.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#%^&")) != nil
        
        if containsLetters && containsNumbers && containsPunctuation && text.count >= 8{
            return Color.green
        }else if containsLetters && !containsNumbers && !containsPunctuation{
            return Color.red
        }else if containsNumbers && !containsLetters && !containsPunctuation{
            return Color.red
        }else if containsLetters && containsNumbers && !containsPunctuation{
            return Color.yellow
        }else if containsLetters && containsNumbers && containsPunctuation{
            return Color.blue
        }else {
            return Color.gray
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            VStack(alignment: .leading, spacing: 10) {
                CheckText (text: "Minimum 8 characters", check: $checkMinChars)
                CheckText (text: "At least one letter", check: $checkLetter)
                CheckText (text: "(I@#$%*^&)", check: $checkPunctuation)
                CheckText (text: "Number", check: $checkNumber)
            }
            
            ZStack{
                if !showPassword{
                    SecureField("Password", text: $text)
                        .padding(.leading).bold()
                        .onChange(of: text, perform: { newValue in
                            withAnimation {
                                progress = min(1.0, max(0, CGFloat(newValue.count) / 8.0))
                                
                                checkMinChars = newValue .count >= 8
                                checkLetter = newValue.rangeOfCharacter(from: .letters) != nil
                                checkNumber = newValue.rangeOfCharacter(from: .decimalDigits) != nil
                                checkPunctuation = newValue.rangeOfCharacter(from:
                                                                                CharacterSet (charactersIn: "!©#%^&")) != nil
                            }
                        })
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10).foregroundColor (.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 10, y: 4)
                        )
                }else{
                    TextField("Password", text: $text)
                        .padding(.leading).bold()
                        .onChange(of: text, perform: { newValue in
                            withAnimation {
                                progress = min(1.0, max(0, CGFloat(newValue.count) / 8.0))
                                
                                checkMinChars = newValue .count >= 8
                                checkLetter = newValue.rangeOfCharacter(from: .letters) != nil
                                checkNumber = newValue.rangeOfCharacter(from: .decimalDigits) != nil
                                checkPunctuation = newValue.rangeOfCharacter(from:
                                                                                CharacterSet (charactersIn: "!©#%^&")) != nil
                            }
                        })
                        .frame(height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10).foregroundColor (.white)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 10, y: 4)
                        )
                }
                
                RoundedRectangle (cornerRadius: 10) .trim(from: 0, to: progress)
                    .stroke(progressColor,lineWidth: 3)
                    .frame(height: 60)
                    .rotationEffect(.degrees(-180))
            }
            .overlay(alignment: .trailing){
                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                    .padding(.trailing, 10)
                    .onTapGesture {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }
            }
        }
        .padding ()
    }
}


struct PasswordStrength_Previews: PreviewProvider {
    static var previews: some View {
        PasswordStrength()
    }
}

struct CheckText: View {
    let text: String
    @Binding var check:Bool
    var body: some View {
        HStack{
            Image (systemName: check ? "checkmark.circle.fill" : "circle")
            Text (text)
        }
        .foregroundColor (check ? .green : .gray)
    }
}
