//
//  BubbleTransition.swift
//  L-Swift
//
//  Created by darktech4 on 13/11/2023.
//

import SwiftUI

struct BubbleTransition: View {
    var body: some View {
        VStack{
            BubbleTransitionView()
            
            DrawBubbleView2()
        }
    }
}

struct BubbleTransitionView: View {
    @State var isVisible: Bool = false

    var body: some View {
        VStack {
            ZStack {
                if isVisible {
                    Text("Hello!")
                        .padding(30)
                        .background {
                            MapOnboardingBubbleShape().fill(Color(.systemGray5))
                        }
                        .transition(.opacity.combined(with: .scale).animation(.spring(response: 0.25, dampingFraction: 0.7)))
                }
            }
            .frame(width: 200, height: 100)
            .padding(.bottom, 50)

            Button(isVisible ? "Hide" : "Show") {
                isVisible.toggle()
            }
        }
    }
}

struct DrawBubbleView2: View {
    @State var drawFraction: CGFloat = 0

    var body: some View {
        VStack {
            MapOnboardingBubbleShape()
                .trim(from: 0, to: drawFraction)
                .stroke(.gray, lineWidth: 3)
                .animation(.spring(), value: drawFraction)
                .frame(width: 150, height: 100)
                .padding(.bottom, 50)

            Button(drawFraction > 0.0 ? "Hide" : "Show") {
                drawFraction = drawFraction > 0.0 ? 0.0 : 1.0
            }
            .tint(Color.gray)
        }
    }
}


struct MapOnboardingBubbleShape: Shape {
    var cornerRadius: CGFloat = 12
    var arrowRectSize: CGFloat = 20
    var arcLength: CGFloat = 12

    /// 0.0 = left, 0.5 = center, 1.0 = right
    var arrowOffsetFraction: CGFloat = 0.5

    func baseXPos(for rect: CGRect) -> CGFloat {
        (rect.maxX - cornerRadius - cornerRadius - arrowRectSize) * arrowOffsetFraction + cornerRadius
    }

    func path(in rect: CGRect) -> Path {
        let roundedRect = Path(roundedRect: rect, cornerRadius: cornerRadius)
        let arrowPath = Path { p in
            p.move(to: .init(x: baseXPos(for: rect), y: rect.maxY))
            p.addLine(to: .init(
                x: baseXPos(for: rect) + arrowRectSize - arcLength,
                y: rect.maxY + arrowRectSize - arcLength
            ))
            p.addQuadCurve(
                to: .init(
                    x: baseXPos(for: rect) + arrowRectSize,
                    y: rect.maxY + arrowRectSize - arcLength
                ),
                control: .init(
                    x: baseXPos(for: rect) + arrowRectSize,
                    y: rect.maxY + arrowRectSize
                )
            )
            p.addLine(to: .init(x: baseXPos(for: rect) + arrowRectSize, y: rect.maxY))
            p.closeSubpath()
        }
        let combinedCGPath = roundedRect.cgPath.union(arrowPath.cgPath)
        let combinedPath = Path(combinedCGPath)
        return combinedPath
    }
}
