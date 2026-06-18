//
//  NetworkManager.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import Foundation


enum CustomErrors : Error {
    case invalidURL
    case decodingError
}

struct ProductResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Hashable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let warrantyInformation, shippingInformation: String
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
}


class NetworkManager {
    
    
    func getProductsData(_ pageNumber: Int = 1) async throws -> ProductResponse? {
        let limit = 20
        let urlString: String = "https://dummyjson.com/products?limit=20&skip=\((pageNumber - 1) * limit)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            throw CustomErrors.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let responseObj = try JSONDecoder().decode(ProductResponse.self, from: data)
            return responseObj
        } catch {
            throw CustomErrors.decodingError
        }
        
        
    }
}
