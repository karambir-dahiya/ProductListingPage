//
//  TestView.swift
//  Product Listing Page
//
//  Created by Siyaa Dahiya on 18/06/26.
//

import SwiftUI

import SwiftUI

// 1. Create a data model that conforms to Hashable
struct GridItemModel: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let backgroundColor: Color
}

struct GridNavigationView: View {
    // Sample grid data source
    let gridItems = [
        GridItemModel(title: "Photos", imageName: "photo", backgroundColor: .blue),
        GridItemModel(title: "Favorites", imageName: "heart.fill", backgroundColor: .red),
        GridItemModel(title: "Settings", imageName: "gearshape", backgroundColor: .gray),
        GridItemModel(title: "Profile", imageName: "person.fill", backgroundColor: .green),
        GridItemModel(title: "Cloud", imageName: "icloud.fill", backgroundColor: .cyan),
        GridItemModel(title: "Trash", imageName: "trash.fill", backgroundColor: .orange)
    ]
    
    // Define a 2-column flexible grid layout
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        // 2. Wrap the interface in a NavigationStack
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(gridItems) { item in
                        
                        // 3. Attach a NavigationLink to the data value of the item
                        NavigationLink(value: item) {
                            GridCellView(item: item)
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents default blue button tint overlay
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            // 4. Listen for the data type click and route to your detail view
            .navigationDestination(for: GridItemModel.self) { selectedItem in
                GridDetailView(item: selectedItem)
            }
        }
    }
}

// MARK: - Extracted Grid Cell View
struct GridCellView: View {
    let item: GridItemModel
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: item.imageName)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text(item.title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(item.backgroundColor)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Destination View
struct GridDetailView: View {
    let item: GridItemModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(item.backgroundColor)
            
            Text("Welcome to the \(item.title) Section")
                .font(.title2)
                .bold()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

