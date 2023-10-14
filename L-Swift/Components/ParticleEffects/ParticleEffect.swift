//
//  ParticleEffect.swift
//  L-Swift
//
//  Created by darktech4 on 12/10/2023.
//

import SwiftUI

extension View{
    @ViewBuilder
    func particaleEffect(systemImage: String, font: Font, status: Bool, activeTint: Color, inActiveTint: Color) -> some View{
        self
            .modifier(
                ParticleModifier(systemImage: systemImage, font: font, status: status, activeTint: activeTint, inActiveTint: inActiveTint)
            )
    }
}

fileprivate struct ParticleModifier: ViewModifier{
    var systemImage: String
    var font: Font
    var status: Bool
    var activeTint: Color
    var inActiveTint: Color
    /// View Props
    @State private var particles: [Particale] = []
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                ZStack{
                    ForEach(particles){ particle in
                        Image(systemName: systemImage)
                            .foregroundColor(status ? activeTint : inActiveTint)
                            .scaleEffect(particle.scale)
                            .offset(x: particle.randomX, y: particle.randomY)
                            .opacity(particle.opacity)
                        // only visible when status is active
                            .opacity(status ? 1 : 0)
                        // making base visibility with zero animation
                            .animation(.none, value: status)
                    }
                }
                .onAppear{
                    //Adding base particles for animation
                    if particles.isEmpty{
                        /// change count as per your wish
                        for _ in 1...15{
                            let pratice = Particale()
                            particles.append(pratice)
                        }
                    }
                }
                .onChange(of: status) { newValue in
                    if !newValue{
                        // reset animation
                        for index in particles.indices{
                            particles[index].reset()
                        }
                    }else{
                        //activating particle
                        for index in particles.indices{
                            //random x & y caculation based on index
                            let total: CGFloat = CGFloat(particles.count)
                            let progress: CGFloat = CGFloat(index) / total
                            
                            let maxX: CGFloat = (progress > 0.5) ? 100 : -100
                            let maxY: CGFloat = 60
                            
                            let randomX: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxX)
                            let randomY: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxY) + 35
                            
                            // MIN SCALE = 0.35
                            // MAX. SCALE = 1
                            let radomScale: CGFloat = .random(in: 0.35...1)
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                
                                let extraRandomX: CGFloat = (progress < 0.5 ? .random(in: 0...10) : .random(in: -10...0))
                                let extraRandomY: CGFloat = .random(in: 0...30)
                                
                                particles[index].randomX = randomX + extraRandomX
                                particles[index].randomY = -randomY - extraRandomY
                            }
                            
                            // scaling with ease animation
                            withAnimation(.easeInOut(duration: 0.4)) {
                                particles[index].scale = radomScale
                            }
                            
                            // removing. particle based on index
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.25 + (Double(index) * 0.005))) {
                                particles[index].scale = 0.001
                                
                            }
                        }
                    }
                }
            }
    }
}


