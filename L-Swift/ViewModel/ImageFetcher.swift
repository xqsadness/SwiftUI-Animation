//
//  ImageFetcher.swift
//  L-Swift
//
//  Created by darktech4 on 13/10/2023.
//

import SwiftUI

class ImageFetcher: ObservableObject {
    @Published var fetchedImage: [ImageModel]?
    
    //MARK: Pagination Props
    @Published var currentPage: Int = 0
    @Published var startPagination: Bool = false
    @Published var endPagination: Bool = false
    
    init(){
        updateImages()
    }
    
    func updateImages(){
        currentPage += 1
        Task{
            do {
                try await fetchImage()
            }catch{
                //err
            }
        }
    }
    
    //MARK: Image JSON Fetching
    func fetchImage()async throws{
        guard let url = URL(string: "https://picsum.photos/v2/list?page=\(currentPage)&limit=30") else{
            return
        }
        
        let resonse = try await URLSession.shared.data(from: url)
        // MARK: reducing image size
        // API call supports image sizing
        let images = try JSONDecoder().decode([ImageModel].self, from: resonse.0).compactMap({ item -> ImageModel? in
            let imageID = item.id
            let sizeUrl = "https://picsum.photos/id/\(imageID)/500/500"
            return .init(id: imageID, download_url: sizeUrl)
        })
        
        await MainActor.run(body: {
            if fetchedImage == nil {fetchedImage = []}
            fetchedImage?.append(contentsOf: images)
            //MARK: Limiting to 100 image
            endPagination = (fetchedImage?.count ?? 0) > 100
            startPagination = false
        })
    }
}
