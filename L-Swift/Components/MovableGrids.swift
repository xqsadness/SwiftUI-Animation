//
//  MovableGrids.swift
//  L-Swift
//
//  Created by xqsadness on 12/10/2023.
//

import SwiftUI

struct MovableGrids: View {
    @State private var colors: [Color] = [.red, .blue, .purple, .yellow, .black, .indigo, .cyan, .pink, .brown, .mint, .orange]
    @State private var draggingItem: Color?
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                let columns = Array(repeating: GridItem(spacing: 10), count: 3)
                LazyVGrid(columns: columns,spacing: 10) {
                    ForEach(colors, id: \.self){ color in
                        GeometryReader {
                            let size = $0.size
                        
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                                .draggable(color){
                                    // custom preview view
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: size.width, height: size.height)
                                        .onAppear{
                                            draggingItem = color
                                        }
                                }
                            // drop
                                .dropDestination(for: Color.self) { items, location in
                                    draggingItem = nil
                                    return false
                                }isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color{
                                        //moving color from source to destination
                                        if let sourceIndex = colors.firstIndex(of: draggingItem), let destinationIndex = colors.firstIndex(of: color){
                                            
                                            withAnimation(.spring()) {
                                                let souceItem = colors.remove(at: sourceIndex)
                                                
                                                colors.insert(souceItem, at: destinationIndex)
                                            }
                                        }
                                    }
                                }
                        }
                        .frame(height: 100)
                    }
                }
                .padding(15)
            }
            .navigationTitle("Movable Grid")
        }
    }
}

struct MovableGrids_Previews: PreviewProvider {
    static var previews: some View {
        MovableGrids()
    }
}
