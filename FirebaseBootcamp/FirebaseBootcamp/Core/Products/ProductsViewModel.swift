//
//  ProductsViewModel.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 04.08.25.
//

import Foundation
import SwiftUI
import FirebaseFirestore

@Observable
@MainActor
final class ProductsViewModel {
    
    private(set) var products: [Product] = []
    var selectedFilter: FilterOption? = nil
    var selectedCategory: CategoryOption? = nil
    
    enum FilterOption: String, CaseIterable {
        case noFilter
        case priceHigh
        case priceLow
        
        var priceDescending: Bool? {
            switch self {
            case .noFilter: return nil
            case .priceHigh: return true
            case .priceLow: return false
            }
        }
    }
    enum CategoryOption: String, CaseIterable {
        case noCategory
        case groceries
        case beauty
        case fragrances
        case furniture
        
        var categoryKey: String? {
            if self == .noCategory {
                return nil
            }
            return self.rawValue
        }
    }
    
    func getAllProducts() async throws {
        self.products = try await ProductsManager.shared.getAllProducts()
    }
    
    func filterSelected(option: FilterOption) async throws {
        self.selectedFilter = option
        try await self.getProducts()
    }
    func catageorySelected(option: CategoryOption) async throws {
        self.selectedCategory = option
        try await self.getProducts()
    }
    
    func getProducts() async throws {
        self.products = try await ProductsManager.shared.getAllProducts(priceDescending: selectedFilter?.priceDescending, forCategory: selectedCategory?.rawValue)

    }
    
    
//    func downloadProductsAndUploadToFirebase() {
//
//        guard let url = URL(string: "https://dummyjson.com/products") else { return }
//        
//        Task {
//            do{
//                let (data, response) = try await URLSession.shared.data(from: url)
//                let products = try JSONDecoder().decode(ProductArray.self, from: data)
//                let productArray = products.products
//                
//                for product in productArray {
//                    try await ProductsManager.shared.uploadProduct(product: product)
//                }
//                print("SUCCESS")
//                print(products.products.count)
//                
//            }catch {
//                print(error)
//            }
//        }
//
//        
//    }

    
    
}
