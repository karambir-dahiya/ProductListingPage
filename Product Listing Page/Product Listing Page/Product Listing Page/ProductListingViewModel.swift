//
//  ProductListingViewModel.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import Combine
import Foundation

class ProductListingViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    var networkManager: NetworkManager
    var pageNumber = 1
    var isLoadingMore = false
    var hasMore = true
    
    init(networkManager : NetworkManager) {
        self.networkManager = networkManager        
    }
    
    func getProducts() async {
        do {
            let productsResponse = try await networkManager.getProductsData(pageNumber)
            guard let products = productsResponse?.products else {
                return
            }
            if products.count == 0 {
                hasMore = false
            }
            self.products.append(contentsOf: products)
            pageNumber += 1
            isLoadingMore = false
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func refreshProducts() async {
        do {
            let productsResponse = try await networkManager.getProductsData(1)
            guard let products = productsResponse?.products else {
                return
            }
            print("Pull to refresh -- 2")
            self.products = products
            pageNumber += 1
            hasMore = true
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func loadMoreIfNeeded(product: Product) async {
        if isLoadingMore || !hasMore {
            return
        }
        guard let index = products.firstIndex(where: {$0.id == product.id}) else { return }
        
        if index >= products.count - 5 {
            print("load more if needed -- 2")
            isLoadingMore = true
            await getProducts()
            
        }
    }
}
