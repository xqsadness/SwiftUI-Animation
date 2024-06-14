//
//  CompositionalView.swift
//  L-Swift
//
//  Created by xqsadness on 13/10/2023.
//

import SwiftUI

// MARK: Building custom view like foreach
struct CompositionalView<Content, Item, ID>: View where Content: View, ID: Hashable, Item: RandomAccessCollection, Item.Element: Hashable{
    var content: (Item.Element)->Content
    var items: Item
    var id: KeyPath<Item.Element, ID>
    var spacing: CGFloat
    
    init(items: Item,id: KeyPath<Item.Element, ID>, spacing: CGFloat = 5, @ViewBuilder
         content: @escaping (Item.Element)->Content) {
        self.content = content
        self.id = id
        self.items = items
        self.spacing = spacing
    }
    
    var body: some View {
        LazyVStack(spacing: spacing){
            ForEach(generateColumns(), id: \.self){ row in
                RowView(row: row)
            }
        }
    }
    
    // MARK: identifying row type
    func layoutType(row: [Item.Element]) -> LayoutType{
        let index = generateColumns().firstIndex{item in
            return item == row
        } ?? 0
        
        //MARK: Layout order will be 1,2,3,1,2,3,...
        var types: [LayoutType] = []
        generateColumns().forEach { _ in
            if types.isEmpty{
                types.append(.type1)
            }else if types.last == .type1{
                types.append(.type2)
            }else if types.last == .type2{
                types.append(.type3)
            }else if types.last == .type3{
                types.append(.type1)
            }else {}
        }
        
        return types[index]
    }
    
    // MARK: row view
    @ViewBuilder
    func RowView(row: [Item.Element]) -> some View{
        GeometryReader{proxy in
            let width = proxy.size.width
            let height = (proxy.size.height - spacing) / 2
            let type = layoutType(row: row)
            let columnWidth = (width > 0 ? ((width - (spacing * 2)) / 3 ) : 0)
            
            HStack(spacing: spacing){
                //MARK: this order in your wish
                if type == .type1{
                    SafeView(row: row, index: 0)
                    VStack(spacing: spacing){
                        SafeView(row: row, index: 1)
                            .frame(height: height)
                        SafeView(row: row, index: 2)
                            .frame(height: height)
                    }
                    .frame(width: columnWidth)
                }
                if type == .type2{
                    HStack(spacing: spacing){
                        SafeView(row: row, index: 1)
                            .frame(width: columnWidth)
                        SafeView(row: row, index: 2)
                            .frame(width: columnWidth)
                        SafeView(row: row, index: 0)
                            .frame(width: columnWidth)
                    }
                }
                if type == .type3{
                    VStack(spacing: spacing){
                        SafeView(row: row, index: 0)
                            .frame(height: height)
                        SafeView(row: row, index: 1)
                            .frame(height: height)
                    }
                    .frame(width: columnWidth)
                    SafeView(row: row, index: 2)
                }
            }
        }
        .frame(height: layoutType(row: row) == .type1 || layoutType(row: row) == .type3 ? 250 : 120)
    }
    
    // MARK: safely. unwrapping content index
    @ViewBuilder
    func SafeView(row: [Item.Element], index: Int) -> some View{
        if (row.count - 1) >= index{
            content(row[index])
        }
    }
    
    //MARK: Constructing custom rows and columns
    func generateColumns() -> [[Item.Element]]{
        var column: [[Item.Element]] = []
        var row: [Item.Element] = []
        
        for item in items{
            // Mark: Each row consists of 3 views
            // optional you can modify
            if row.count == 3{
                column.append(row)
                row.removeAll()
                row.append(item)
            }else{
                row.append(item)
            }
        }
        // Mark: adding exhaust ones
        column.append(row)
        row.removeAll()
        return column
    }
}


struct CompositionalView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCompositional()
    }
}

enum LayoutType{
    case type1
    case type2
    case type3
}
