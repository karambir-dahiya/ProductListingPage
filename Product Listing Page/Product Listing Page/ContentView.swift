//
//  ContentView.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ProductListingViewModel(networkManager: NetworkManager())
    
    @State var searchText = ""
    
    let columns = [GridItem(.flexible(minimum: 100, maximum: 150)), GridItem(.flexible(minimum: 100, maximum: 150))]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.products, id: \.self) { product in
                            NavigationLink(value: product) {
                                ProductCell(product: product)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            .onAppear {
                                Task {
                                   await  viewModel.loadMoreIfNeeded(product: product)
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "Search products")
                .refreshable { Task {  await viewModel.refreshProducts()  }  }
            }
            .padding()
            .task {   await viewModel.getProducts()  }
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
        }.navigationTitle("Products")
            
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }.navigationTitle("Products")
    
}
