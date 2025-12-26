//
//  SpotifyPlaylistView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 07.12.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    @Environment(\.router) var router
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var headerOffset: CGFloat = 0     // используем для затемнения
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        heigth: 250,
                        title: product.title,
                        subtitle: product.brand ?? "Unknown",
                        imageName: product.thumbnail
                    )
                }
                .readingFrame { frame in
                    // frame.maxY уменьшается при прокрутке вверх
                    headerOffset = max(0, 250 - frame.maxY)
                }
                
                PlaylistDescriptionCell(
                    descriptionText: product.description,
                    userName: user.firstName,
                    subhedline: product.category ?? "Unknown",
                    onAddToPlaylistPressd: nil,
                    onDownloadPressd: nil,
                    onSharePressd: nil,
                    onEllipsisPressd: nil,
                    onShufflePressd: nil,
                    onPlayPressd: nil
                )
                
                ForEach(products) { product in
                    SongRowCell(
                        imageSize: 70,
                        imageName: product.firstImage,
                        title: product.title,
                        subtitle: product.brand,
                        onCellPressed: {
                            goToPlaylistView(product: product)
                        },
                        onEllipsisPressed : {
                            
                        }
                    )
                }
            }
            .scrollIndicators(.hidden)
            
            // 🔥 Заголовок (темнеет при прокрутке)
            headerView
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product , user: user)
        }
    }
    
    
    // MARK: - Header View with fade
    private var headerView: some View {
        
        // рассчитываем плавное затемнение
        // 0 → 120 px = от 0 до 1 opacity
        let opacity = min(max(headerOffset / 120, 0), 1)
        
        return ZStack {
            // Текст с затемняющим фоном
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(opacity))
            
            // Кнопка назад
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(Color.black.opacity(0.2 + opacity * 0.6))
                .clipShape(Circle())
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    router.dismissScreen()
                }
        }
        .foregroundStyle(.spotifyWhite)
        .animation(.smooth(duration: 0.15), value: opacity)
    }
    
    
    // MARK: - Data
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            print("Error:", error)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}
