//
//  User.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//
// ВЕРСИЯ МОДЕЛИ ИЗ ВИДЕОУРОКА
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
    
    var work: String {
        "I work as a developer"
    }
    var education: String {
        "Stanford University"
    }
    var aboutMe: String {
        "This is a sentence of about me, that looks good in my profile!"
    }
    
    var basics: [UserInterest] {
        [
          UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
          UserInterest(iconName: "graduationcap", emoji: nil, text: education),
          UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
          UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo")
        ]
    }
    var interests: [UserInterest] {
        [
          UserInterest(iconName: nil, emoji: "🏃‍♂️", text: "Running"),
          UserInterest(iconName: nil, emoji: "🏋️‍♀️", text: "Gym"),
          UserInterest(iconName: nil, emoji: "🎧", text: "Music"),
          UserInterest(iconName: nil, emoji: "🥗", text: "Cooking")
        ]
    }
    
    var images: [String] {
        ["https://picsum.photos/400/400", "https://picsum.photos/500/500", "https://picsum.photos/700/700"]
    }
    
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


