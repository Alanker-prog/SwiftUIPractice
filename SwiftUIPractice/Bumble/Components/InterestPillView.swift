//
//  InterestPillView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 16.01.2026.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String?
    var emoji: String?
    var text: String = "Graduate Degree"
    
    var body: some View {
        HStack {
            if let iconName {
                Image(systemName: iconName)
            } else if let emoji {
                Text(emoji)
            }
            
            Text(text)
        }
        .font(.callout)
        .padding()
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleLightBlue)
        .clipShape(.capsule)
    }
}

#Preview {
    VStack {
        InterestPillView(iconName: "heart.fill")
        InterestPillView(emoji: "🙂")
        InterestPillView()
    }
    
}
