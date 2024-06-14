//
//  HomeCompositional.swift
//  L-Swift
//
//  Created by xqsadness on 13/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCompositional: View {
    @StateObject var imageFetcher: ImageFetcher = .init()
    var body: some View {
        NavigationView {
            Group{
                // Mark: Custom view
                if let images = imageFetcher.fetchedImage{
                    ScrollView{
                        CompositionalView(items: images, id: \.id) { item in
                            GeometryReader{proxy in
                                let size = proxy.size
                                
                                WebImage(url: URL(string: item.download_url))
                                    .placeholder(
                                        Image("placeholder_image")
                                            .resizable()
                                    )
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .cornerRadius(10)
                                    .onAppear{
                                        if images.last?.id == item.id{
                                            imageFetcher.startPagination = true
                                        }
                                    }
                            }
                        }
                        .padding()
                        .padding(.bottom,10)
                        
                        if imageFetcher.startPagination && !imageFetcher.endPagination{
                            ProgressView()
                                .offset(y: -15)
                                .onAppear{
                                    //MARK: slight delay
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        imageFetcher.updateImages()
                                    }
                                }
                        }
                    }
                }else{
                    ProgressView()
                }
            }
            .navigationTitle("Compositional Layout")
        }
    }
}

struct HomeCompositional_Previews: PreviewProvider {
    static var previews: some View {
        HomeCompositional()
    }
}
