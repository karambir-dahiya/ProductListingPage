//
//  ProductDetailView.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import SwiftUI

struct ProductDetailView: View {
    var product : Product
    
    var body: some View {
        VStack(spacing: 15) {
                CacheImageView(urlString: product.thumbnail)
                    .scaledToFit()
                Text(product.title)
                .font(.title2)
                Text(product.description)
                Spacer()
        }.padding()
        .navigationTitle("Product Details")

    }
}
//
//#Preview {
//    ProductDetailView()
//}
