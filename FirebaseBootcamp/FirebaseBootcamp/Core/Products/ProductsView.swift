//
//  ProductsView.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 04.08.25.
//

import SwiftUI

struct ProductsView: View {
    @State private var viewModel = ProductsViewModel()

    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "NONE")") {
                    
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.filterSelected(option: option)
                            }
                        }

                    }
                    
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Category: \(viewModel.selectedCategory?.rawValue ?? "NONE")") {
                    ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.catageorySelected(option: option)
                            }
                        }
                    }
                }
            }

        })
        .task {
            try? await viewModel.getAllProducts()
        }
    }
    

}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
