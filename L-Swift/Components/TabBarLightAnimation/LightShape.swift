//
//  LightShape.swift
//  L-Swift
//
//  Created by xqsadness on 17/06/2024.
//

import SwiftUI

struct Lightshape: View {
    var body: some View {
        LineShape()
            .frame(width: 50, height: 150)
            .foregroundStyle (
                LinearGradient(
                    stops:
                        [
                            .init(
                                color: .bgrYellow,
                                location: 0.30
                            ),
                            .init(
                                color: .clear,
                                location: 0.64
                            )
                        ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay (alignment: .bottom) {
                Rectangle()
                    .frame(width: 50, height: 25)
                    .offset(y: -46)
                    .foregroundStyle(LinearGradient (gradient: Gradient (colors: [.clear,.bgGray,.bgGray]), startPoint: .top, endPoint: .bottom))
                    .blur(radius: 4)
            }
    }
}

#Preview {
    Lightshape()
}

struct LineShape: Shape{
    func path (in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 12, y: 40))
        path.addLine(to: CGPoint(x: 38, y: 40))
        path.addLine(to: CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 0.5, y: 100))
        return path
    }
}
