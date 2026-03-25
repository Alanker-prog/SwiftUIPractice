//
//  User.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//
import Foundation

// MARK: - User

struct User: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let email: String
    let phone: String
    let username: String
    let password: String
    let image: String
    let height: Double
    let weight: Double
}

// MARK: - Computed Properties

extension User {
    
    var fullName: String { "\(firstName) \(lastName)" }
    
    var work: String       { "I work as a developer" }
    var education: String  { "Stanford University" }
    var aboutMe: String    { "This is a sentence about me that looks good on my profile!" }
    
    var profileImages: [String] {
        [
            "https://picsum.photos/400/400",
            "https://picsum.photos/500/500",
            "https://picsum.photos/700/700"
        ]
    }
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler",            emoji: nil, text: "\(Int(height)) cm"),
            UserInterest(iconName: "graduationcap",    emoji: nil, text: education),
            UserInterest(iconName: "wineglass",        emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill",  emoji: nil, text: "Virgo")
        ]
    }
    
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "🏃‍♂️", text: "Running"),
            UserInterest(iconName: nil, emoji: "🏋️‍♀️", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🎧",   text: "Music"),
            UserInterest(iconName: nil, emoji: "🥗",   text: "Cooking")
        ]
    }
}

// MARK: - Mock

extension User {
    static var mock: User {
        User(
            id: 444,
            firstName: "Alan",
            lastName: "Parastaev",
            age: 37,
            email: "alan@example.com",
            phone: "+1234567890",
            username: "alanker",
            password: "",
            image: Constants.randomImage,
            height: 180,
            weight: 65
        )
    }
}
