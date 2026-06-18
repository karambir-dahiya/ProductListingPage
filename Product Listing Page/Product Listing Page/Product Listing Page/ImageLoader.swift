//
//  ImageLoader.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import SwiftUI
import Foundation
import UIKit
import Combine

class ImageCache {
    static var shared = ImageCache()
    var imageCache = NSCache<NSString, UIImage>()
    private init() { }
    
    func saveImageToCache(uiImage: UIImage, name: String) {
        imageCache.setObject(uiImage, forKey: name as NSString)
    }
    
    func getImageFromCache(name: String)-> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
    func deleteImageFromCache(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
}

final class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    func loadImage(urlString: String) {
        
        if let image = ImageCache.shared.getImageFromCache(name: urlString) {
            self.image = image
            return
        }
        
        guard let url = URL(string:urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            ImageCache.shared.saveImageToCache(uiImage: downloadedImage, name: urlString)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
            
            
            
        }.resume()
        
    }
}


struct CacheImageView: View {
    var urlString: String
    @StateObject private var loader = ImageLoader()
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
            }  else {
                ProgressView()
            }
        }.onAppear {
            loader.loadImage(urlString: urlString)
        }
        
    }
}
