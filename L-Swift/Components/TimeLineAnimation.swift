//
//  TimeLineAnimationView.swift
//  L-Swift
//
//  Created by xqsadness on 14/06/2024.
//

import SwiftUI

struct TLModel: Identifiable{
    var id = UUID()
    var title: String
    var isCompleted: Bool
}

struct TimeLineAnimationView: View {
    
    @State private var list: [TLModel] = [
        TLModel(
            title: "Hello world",
            isCompleted: false
        ),
        TLModel(
            title: "SwiftUI Animation",
            isCompleted: false
        ),
        TLModel(
            title: "Xcode 14+, IOS 16+",
            isCompleted: false
        )
    ]
    
    var body: some View {
        LazyVStack(spacing: 0){
            ForEach(list.indices, id: \.self) { item in
                let todo = list[item]
                
                HStack(spacing: 15){
                    Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                        .imageScale(.medium)
                        .foregroundStyle(todo.isCompleted ? .green : .text)
                    
                    Text(todo.title)
                        .strikethrough(todo.isCompleted)
                        .lineLimit(1)
                        .animation(.none, value: todo.isCompleted)
                    Spacer()
                }
                .overlay(alignment: .topLeading) {
                    Rectangle()
                        .frame(width: 1, height: todo.isCompleted ? 53 : 0)
                        .offset(y: 20)
                        .padding(.leading, 9)
                }
                .frame(height: 70)
                .animation(.bouncy, value: todo.isCompleted)
                .hAlign(.leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        list[item].isCompleted.toggle()
                    }
                }
            }
            
            VStack{
                if !list.isEmpty{
                    HStack(spacing: 15){
                        Image(systemName: list.allSatisfy({$0.isCompleted}) ? "checkmark.circle.fill" : "circle")
                            .imageScale(.medium)
                        
                        Text("Finish")
                        
                        Spacer()
                    }
                    .foregroundStyle(list.allSatisfy({$0.isCompleted}) ? .green : .gray)
                    .frame(height: 46, alignment: .bottom)
                    .animation(.bouncy, value: list.allSatisfy({$0.isCompleted}))
                    .onTapGesture {
                        let allTrue = list.allSatisfy({$0.isCompleted})
                        
                        let delayStep = 0.5
                        let indices = allTrue ? Array(list.indices.reversed()) : Array(list.indices)
                        for (offset , item) in indices.enumerated(){
                            let delay = Double (offset) * delayStep
                            DispatchQueue.main.asyncAfter (deadline: .now() + delay) {
                                self.list[item].isCompleted = !allTrue
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TimeLineAnimationView()
}
