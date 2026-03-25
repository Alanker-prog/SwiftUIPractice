//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import Foundation

// MARK: - Product

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let category: String?
    let images: [String]
    let thumbnail: String
}

// MARK: - Computed Properties
// Это расширение что бы очистить SpotifyPlaylistView от ?? и написать там чистый код (что бы не разворачивать Product в основной вью)
extension Product {
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    // recentlyAdded вынесен в extension — не влияет на Codable
    // и не ломает инициализатор при декодировании
    var recentlyAdded: Bool {
        id % 4 == 0  // детерминированно — не меняется при каждом рендере
    }
    
    // Безопасные значения для UI
    var safeBrand: String       { (brand ?? "Unknown").capitalized }
    var safeCategory: String    { (category ?? "Unknown").capitalized }
    var categoriesDisplay: [String] {
        [category?.capitalized, brand].compactMap { $0 }
    }
}

// MARK: - Mock
/*
✴️ Это мокет данных на struct Product
   ➡️ Обычно mock создают если еще не готов бекэнд, это позволяет верстать UI заранее и дожидаться сервер
   ➡️ Так же в основном вью вмето все этих параметров можно просто писать Product.mock (лучшаяя читаемость)
 
 ✅ используется в preview / тестах / разработке
 ❌ не используется в продакшене. Это инструмент, а не реальные данные.
 ⚠️ Возможно моки вынести в отдельный файл: Чтобы было понятно, что это не боевая логика.
 */
extension Product {
    static var mock: Product {
        Product(
            id: 123,
            title: "AirPods Pro 2",
            description: "Noise-cancelling wireless earbuds with improved sound quality.",
            price: 249,
            discountPercentage: 15,
            rating: 4.8,
            stock: 120,
            brand: "Apple",
            category: "Electronic Devices",
            images: [Constants.randomImage],
            thumbnail: Constants.randomImage
        )
    }
    
    static var mockArray: [Product] {
        (1...10).map { i in
            Product(
                id: i,
                title: "Product \(i)",
                description: "Description for product \(i)",
                price: Double(i) * 9.99,
                discountPercentage: 10,
                rating: 4.5,
                stock: 100,
                brand: "Brand \(i)",
                category: "Category",
                images: [Constants.randomImage],
                thumbnail: Constants.randomImage
            )
        }
    }
}

// MARK: - ProductRow
/*
 ✴️ Эта доп структура нужна только для отображения listRows(она формирует как будет выглядить listRows в основном view)
    🟢 Identifiable и let id = UUID().uuidString
       ➡️ Что бы прогнать через ForEach, каждая секция должна иметь уникальный id
 
    🟢 let title: String - заголовок
    🟢 let products: [Product] - список продуктов
 */
struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
