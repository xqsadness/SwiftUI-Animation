//
//  CustomTextField.swift
//  L-Swift
//
//  Created by darktech4 on 11/10/2023.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var hint: String
    var leadignIcon: Image
    var isPassword: Bool = false
    
    var body: some View {
        HStack(spacing: 0){
            leadignIcon.font(.callout).foregroundColor(.gray)
                .frame(width: 40, alignment: .leading)
            
            if isPassword{
                SecureField(hint, text: $text)
            }else{
                TextField(hint, text: $text)
            }
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.gray.opacity(0.1))
        )
    }
}
