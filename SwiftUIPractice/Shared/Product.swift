//
//  Product.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import Foundation


struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable , Identifiable{
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand, category: String?
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constans.randomImage
    }
    
    /*
    ✴️ Это мокет данных на struct Product
       ➡️ Обычно mock создают если еще не готов бекэнд, это позволяет верстать UI заранее и дожидаться сервер
       ➡️ Так же в основном вью вмето все этих параметров можно просто писать Product.mock (лучшаяя читаемость)
     
     ✅ используется в preview / тестах / разработке
     ❌ не используется в продакшене. Это инструмент, а не реальные данные.
     ⚠️ Возможно моки вынести в отдельный файл: Чтобы было понятно, что это не боевая логика.
     */
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
            images: [Constans.randomImage, Constans.randomImage, Constans.randomImage],
            thumbnail: Constans.randomImage
        )
    }
}

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


// Это расширение что бы очистить SpotifyPlaylistView от ?? и написать там чистый код (что бы не разворачивать Product в основной вью)
extension Product {
    var safeTitle: String { title }
    var safeBrand: String { (brand ?? "Unknown").capitalized }
    var safeDescription: String { description }
    var safeCategory: String { (category ?? "Unknown").capitalized }
    var safeThumbnail: String { thumbnail }
}



