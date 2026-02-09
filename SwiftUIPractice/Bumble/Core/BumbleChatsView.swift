//
//  BumbleChatsView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 04.02.2026.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    
    @Environment(\.router) var router
    
    @State private var allUsers: [User] = []
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack {
                Header
                    .padding(15)
                
                matchQueueSection
                
                recenntChatsSection
            }
            
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    // MARK: - Data

    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print("Error:", error)
        }
    }
    
    
    private var Header: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .onTapGesture {
                    router.dismissScreen()
                }
            
            Spacer(minLength: 0)
            
            Image(systemName: "sparkle.magnifyingglass")
        }
        .font(.largeTitle)
        .fontWeight(.medium)
    }

    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Match Queue (\(allUsers.count))")
                .padding(.horizontal, 15)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentegeRemaining: Double.random(in: 0...1),
                            hasNewMassege: Bool.random()
                        )
                    }
                }
                .padding(.horizontal, 15)
            }
            .scrollIndicators(.hidden)
            .frame(height: 100)
        }
        .font(.title2)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var recenntChatsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("Chats (Recent)")
                
                Spacer(minLength: 0)
                
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.title2)
            }
                .padding(.horizontal, 15)
            
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(allUsers) { user in
                        BumbleChatPreviewCeel(
                            imageName: user.image,
                            percentegeRemaining: Double.random(in: (0...1)),
                            hasNewMassege: Bool.random(),
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random()
                        )
                    }
                }
                .padding(15)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    BumbleChatsView()
}



