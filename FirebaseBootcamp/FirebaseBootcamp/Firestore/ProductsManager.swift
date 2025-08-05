//
//  ProductsManager.swift
//  FirebaseBootcamp
//
//  Created by Dhiman Das on 04.08.25.
//

import Foundation
import FirebaseFirestore

final class ProductsManager {
    static let shared = ProductsManager()
    private init() { }
    
    private let productsCollection = Firestore.firestore().collection("products")
    
    
    private func productDocument(productId: String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    func uploadProduct(product: Product) async throws {
        try productDocument(productId: String(product.id)).setData(from: product, merge: false)
    }
    
    func getProduct(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
    
    func getAllProducts() async throws -> [Product] {
        let snapshot = try await productsCollection.getDocuments()
        
        var products: [Product] = []
        
        for document in snapshot.documents {
            let product = try document.data(as: Product.self)
            products.append(product)
        }
        return products
    }
    private func getAllProductsSortedByPrice(descending: Bool) async throws -> [Product] {
        try await productsCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
            .getDocuments(as: Product.self)
    }
    
    private func getAllProductsForCategory(category: String) async throws -> [Product] {
        try await productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
            .getDocuments(as: Product.self)
    }
    
    private func getAllProductsByPriceAndCategory(descending: Bool, category: String) async throws -> [Product] {
        
        let products = try await productsCollection
            .whereField(Product.CodingKeys.price.rawValue, isEqualTo: category)
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
            .getDocuments(as: Product.self)
        print(products)
        return products
    }
    
    
    func getAllProducts(priceDescending descending: Bool?, forCategory category: String?) async throws -> [Product] {
        
        if let descending , let category {
            return try await getAllProductsByPriceAndCategory(descending: descending, category: category)
        }
        else if let descending {
            return try await getAllProductsSortedByPrice(descending: descending)
        }
        else if let category {
            return try await getAllProductsForCategory(category: category)
        }
        return try await getAllProducts()
    }
    
    private func getAllProductsSortedByPriceQuery(descending: Bool) -> Query {
        productsCollection
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    
    private func getAllProductsForCategoryQuery(category: String) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
    }
    
    private func getAllProductsByPriceAndCategoryQuery(descending: Bool, category: String) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.category.rawValue, isEqualTo: category)
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }


    
//    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
//        let snapshot = try await self.ge
//    }
    
    
//    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
//        try await getDocumentsWithSnapshot(as: type).products
//    }

}

extension Query {
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map ({ dcument in
            try dcument.data(as: T.self)
            
        })
        
    }
}
