//
//  SpotifyHomeView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 02.12.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

// Что нужно сделать если нужно перейти на MVVM
/*
 (🟢 Создаем наблюдаемый финальный класс)
@Observable
final class SpotifyHomeViewModel {
    
    (🟢 router без @Environment, потому-что среда уже внедрена в ViewModel)
    let router: AnyRouter
 
   (🟢 Переносим все переменные из SpotifyHomeView, делаим их без состояния(@State) и не приватными!)
       (⚠️ В этом классе состоянием(@State) ❕управляет @Observable❕,по этому мы можем исбавиться от @State)
       (🔥 Эти пременные имеют значения по умолчанию ,поэтому не обязаны инициализироваться в init)
     var currentUser: User? = nil
     var selectedCategory: Category? = nil
     var products: [Product] = []
     var productRow: [ProductRow] = []

 (🟢 init — это инициализатор, он вызывается в момент создания SpotifyHomeViewModel. Его задача здесь — передать и сохранить роутер внутри ViewModel.)
     (➡️ router (справа) — параметр, который пришёл в init)
     (➡️ self.router (слева) — свойство класса)
 
    init(router: AnyRouter) {
        self.router = router
    }
    
   (🟢 Функцию тоже преносим в ViewModel и делаем ее не приватной)
      (⚠️ После этого в задаче(task) в SpotifyHomeView вызываем метод через(viewModel)   -> task { await viewModel.getData() }   )
 
     func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))

            // Формируем ProductRow — каждый продукт как отдельный ряд
                        var rows: [ProductRow] = []
                        for product in products {
                            let title = (product.brand ?? "Unknown").capitalized
                            rows.append(ProductRow(title: title, products: products))
                        }
                        productRow = rows
        } catch {
            print("Error:", error)
        }
    }
    
}
 
(🟢 В привью нужно будет передать router)
#Preview {
    RouterView { router in
        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
    }
}
 
(⚠️ В ContentView нужно тоже предать router)
 List {
     Button("Open Spotify") {
         router.showScreen(.fullScreenCover) { router in
             SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
         }
*/

struct SpotifyHomeView: View {
    
   // Когда ты создаёшь ViewModel, ты обязан передать роутер: ViewModel не создаётся без роутера навигация — обязательная зависимость
   // @State var viewModel: SpotifyHomeViewModel(router: router)  - Для ViewModel
    @Environment(\.router) var router

    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRow: [ProductRow] = []


    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            // LazyVStack - важен для производительности
            // ❌ Внутри LazyVStack Не ипользовать LazyHStack(не будет плавности)
            ScrollView(.vertical) {
                LazyVStack( spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack {
                            recentsSelection
                                .padding(.horizontal, 3)
                            
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 3)
                            }
                            
                        }
                        
                        listRows
                        
                    } header: {
                        header
                    }

                }
            }
            .scrollIndicators(.hidden)
            .clipped()
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: Объяснение метода
     /*
     🔥Проверка,загружены ли продукты:
     🟢 guard products.isEmpty else { return }
       🔸 Проверяется массив products.
          ➡️ Если products пустой то код в функции отработает,а если НЕ пустой выполняется return и функция сразу завершается
          ⚠️ Если этого не написать массив будет загрузаться каждый раз заново, Если кпримеру ты перешол на другой экран и вернулся обратно там будут совсем другие данные
          ❕Зачем это нужно: Чтобы не загружать данные повторно и Предотвращает лишние запросы к базе данных

      🔥Загрузка текущего пользователя:
      🟢 currentUser = try await DatabaseHelper().getUsers().first
         ➡️ Пробуем загрузить из DatabaseHelper() через асинхронную функцию getUsers().❕Метод возвращает массив пользователей❕но мы загружаем только первого пользователя .first
         ‼️Возможная проблема: Если массив пуст — first вернёт nil
     
     🔥 Загрузка продуктов (первые 8)
     🟢 products = try await Array(DatabaseHelper().getProducts().prefix(8))
        ➡️ Пробуем загрузить из DatabaseHelper() через асинхронную функцию getProducts()
        ➡️ Array(...) — превращает prefix в обычный массив, что бы использовать .prefix нужно обернуть все в массив(❌ У меня была проблема на экране бескончные ячейки в ScrollView и я ограничил колличество ячеек префиксом до 8 тш.)
        ➡️ .prefix(8) — берёт первые 8 элементов

     🔥 Создание пустого массива строк
     🟢 var rows: [ProductRow] = []
        ➡️ Создаём пустой массив rows, Типа — ProductRow
     
     🔥 Цикл по продуктам
     🟢 for product in products {
        ➡️ Перебираем каждый продукт в массиве products
     
     🔥 Формирование заголовка строки
     🟢 let title = (product.brand ?? "Unknown").capitalized
        ➡️ Берем бренды(.brand) из массива productов используем для заголовка в ячейки
        ➡️ ?? "Unknown" - нужен для, если у .brandа будет nil(нет названия) у нас не ляжет приложение
     
     🔥 Создание ProductRow
     🟢 rows.append(ProductRow(title: title, products: products))
        ➡️ title — бренд текущего продукта
        ➡️ products — весь массив продуктов (не один продукт!)
        ⚠️ Важно: Каждый ProductRow содержит один и тот же массив products, меняется только title
     
     🔥 Присваивание результата
     🟢 productRow = rows
        ➡️ Готовый массив строк сохраняется в productRow
        ➡️ Обычно используется для отображения в UI (например, List или ScrollView)
    
     */
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))

            // Формируем ProductRow — каждый продукт как отдельный ряд
                        var rows: [ProductRow] = []
                        for product in products {
                            let title = (product.brand ?? "Unknown").capitalized
                            rows.append(ProductRow(title: title, products: products))
                        }
                        productRow = rows
        } catch {
            print("Error:", error)
        }
    }



    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
    }
    
    private var recentsSelection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product  {
                SpotifyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product , user: currentUser)
        }
    }
    
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            hedline: product.brand,
            subhedline: product.category,
            title: product.title,
            subtitle: product.description) {
                
            } onPlayPressed: {
                goToPlaylistView(product: product)
            }
    }
    
    private var listRows: some View {
        ForEach(productRow) { row in
            VStack {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.vertical, 10)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton {
                                goToPlaylistView(product: product)
                            }
                            
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
                
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}
