//
//  BumbleHomeView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 13.01.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {

    @Environment(\.router) var router
    
    @State private var filters: [String] = ["Everyone", "Trending", "Home"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"

    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0

    // key: User.id, value: swipe direction (true = like, false = dislike)
    @State private var cardOffsets: [Int: Bool] = [:]

    @State private var currentSwipeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 8) {
                header

                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)

                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(allUsers, id: \.id) { user in
                            let index = indexForUser(user)

                            let isPrevious = selectedIndex - 1 == index
                            let isCurrent  = selectedIndex == index
                            let isNext     = selectedIndex + 1 == index

                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffsets[user.id]

                                userProfileCell(user: user)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(
                                        x: offsetValue == nil
                                        ? 0
                                        : offsetValue == true ? 900 : -900
                                    )
                            }
                        }
                    } else {
                        ProgressView()
                    }

                    overlaySwipingIndicator
                        .zIndex(999_999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }

    // MARK: - Actions

    private func userDidSelect(user: User, isLike: Bool) {
        cardOffsets[user.id] = isLike
        selectedIndex += 1
        currentSwipeOffset = 0
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

    // MARK: - Helpers

    private func indexForUser(_ user: User) -> Int {
        allUsers.firstIndex(where: { $0.id == user.id }) ?? 0
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "list.bullet")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }

                Image(systemName: "arrow.uturn.backward")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatsView()
                    }
                }
        }
        .font(.title2)
        .fontWeight(.medium)
    }

    // MARK: - Card

    private func userProfileCell(user: User) -> some View {
        BumbleCardView(
            user: user,
            onSuperLikeTap: nil,
            onXmarkTap: {
                userDidSelect(user: user, isLike: false)
            },
            onCheckmarkTap: {
                userDidSelect(user: user, isLike: true)
            },
            onSendComplimentTap: nil,
            onHideAndReportTap: {}
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    guard abs(value.translation.width) > abs(value.translation.height) else { return }
                    currentSwipeOffset = value.translation.width
                }
                .onEnded { value in
                    guard abs(value.translation.width) > abs(value.translation.height) else { return }

                    if value.translation.width > 50 {
                        userDidSelect(user: user, isLike: true)
                    } else if value.translation.width < -50 {
                        userDidSelect(user: user, isLike: false)
                    }
                }
        )
    }

    // MARK: - Overlay Indicators

    private var overlaySwipingIndicator: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.title3)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)

            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.title3)
                }
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}
