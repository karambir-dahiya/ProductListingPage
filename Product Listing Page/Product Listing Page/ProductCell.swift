//
//  ProductCell.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import SwiftUI
struct ProductCell: View {
    
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CacheImageView(urlString: product.thumbnail)
                .scaledToFit()
            Text(product.title)
                .font(.callout)
            Text(product.description)
                .lineLimit(2)
                .font(.caption)
            
        }
    }
    
   
}
