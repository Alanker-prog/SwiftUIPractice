//
//  BumbleHeartView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 14.01.2026.
//

import SwiftUI

struct BumbleHeartView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .offset(y: 1)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
                .font(.system(size: 10))
                .offset(x: 0.3, y: -1 )
            
            
        }
    }
}

#Preview {
    BumbleHeartView()
}
