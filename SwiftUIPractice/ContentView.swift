//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
        }
        
    }
    
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
