//
//  User.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double // <- Double not Int
    let weight: Double
    
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Alan",
            lastName: "Parastaev",
            age: 37,
            email: "hkzk@ksdk",
            phone: "",
            username: "",
            password: "",
            image: Constans.randomImage,
            height: 180,
            weight: 65
        )
    }
}
