//
//  ArcMenuButton.swift
//  L-Swift
//
//  Created by darktech4 on 13/10/2023.
//

import SwiftUI

struct ArcMenuButton: View {
    @State var isExpanded = false
    let buttons: [ArcMenuButtonName]
    
    var ontap: (ArcMenuButtonName) -> Void
    var body: some View {
        ZStack{
            ForEach(buttons.indices, id: \.self){ index in
                Image(systemName: buttons[index].rawValue)
                    .frameWH(width: 10, height: 10)
                    .padding()
                    .background(Color(.systemGray6))
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                    .offset(x: isExpanded ? CGFloat(Foundation.cos((Double(index) * 45 + 135) * Double.pi / 180) * 60 ) : 0,
                            y: isExpanded ? CGFloat(Foundation.sin((Double(index) * 45 + 135) * Double.pi / 180) * 60) : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0).delay(Double(index) * 0.15), value: isExpanded)
                    .onTapGesture {
                        ontap(buttons[index])
                    }
            }
            
            Button{
                withAnimation {
                    isExpanded.toggle()
                }
            }label :{
                Image(systemName: isExpanded ? "xmark" : "plus")
                    .frame(width: 20, height:20)
                    .foregroundColor(.gray)
                    .padding(15)
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
            }
        }
    }
}

// Use like this
struct ArcMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
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
            .hAlign(.trailing)
            .vAlign(.bottom)
            .padding()
        }
    }
}

//Add button here
enum ArcMenuButtonName: String {
    case capture = "circle"
    case star = "star"
    case noti = "bell"
    case bookmark = "bookmark"
    
    static var allCases: [ArcMenuButtonName] {
        return [.capture, .star, .noti, .bookmark]
    }
}

