//
//  NetflixMovieDetailsView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 18.03.2026.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMovieDetailsView: View {
    
    @Environment(\.router) var router
    
    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress
                ) {
                    
                } onXMarkTap: {
                    router.dismissScreen()
                }

                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailsProductSection
                        buttonSection
                        productGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        do {
             products = try await DatabaseHelper().getProducts()
        } catch {
            print("Error:", error)
        }
    }
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailsView(product: product)
        }
    }
    
    private var detailsProductSection: some View {
        NetflixDitailsProductView(
            title: product.title,
            isNew: true,
            yearReleased: "2026",
            seasonCount: 4,
            hasClosedCaptions: true,
            isTopTen: 7,
            descriptionText: product.description,
            castText: "Cast: Alan, unknown film Netflix") {
                
            } onDownloadTap: {
                
            }
    }
    
    private var buttonSection: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                // do something with selection
            }
            
            ShereButton()
        }
        .padding(.leading, 32)
    }
    
    private var productGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), alignment: .center, spacing: 8, pinnedViews: []) {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: product)
                    }
                }
            }
            
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    RouterView { _ in
        NetflixMovieDetailsView()
    }
}
