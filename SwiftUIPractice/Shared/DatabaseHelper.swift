//
//  DatabaseHelper.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import Foundation

struct DatabaseHelper {
    
/*
 🔴 DatabaseHelper - это файл в котором обычно:(сетевой запрос,Firebase, локальная БД,mock-данные)
 
🟢 func getProducts() async throws -> [Product]
   🔹 Создаем асинхронная функцию(может выбрасывать ошибку throws, если данные не полученны). Возврашает массив прродуктов [Product] из модели Product
     
🟢 guard let url = URL(string: "https://dummyjson.com/products")
  🔹 Проверяем что данные с этого API получены, если полученны данные загружаем их в константу (let url).
  🔹 А если данные не полученны выбрасываем ошибку else { throw URLError(.badURL) }. Например если интернет недоступен или данные повреждены).
  🔹 URLError(.badURL) 👉 Это защита от неправильного адреса.
 
     
🟢 let (data , _ ) = try await URLSession.shared.data(from: url)
   🔹 try await URLSession.shared.data(from: url) - Отправляем GET-запрос по указанному URL и на получение данных с url:
   🔹 try await:
      try - Если запрос не удался (нет интернета, 404, таймаут), будет выброшена ошибка.
      await — ждём завершения асинхронного запроса
   🔹 URLSession.shared - Глобальный объект для выполнения сетевых запросов.
   🔹 data(from: url) - Отправляет GET-запрос по указанному URL и Возвращает url кортеж с данными
   🔹 let (data , _ ) - url возврвшает кортеж с данными в виде(Data , Responce) - (Данных и Ответа).
      В нашем примере данные(data) пишем с маленькой буквы, а Responce игнорируем(_)
 
🟢 let products = try JSONDecoder().decode(ProductArray.self, from: data)
   ⚠️ преобразуем JSON в Swift-объект , ProductArray.self — это модель, которая соответствует структуре JSON.
   🔹 try JSONDecoder().decode(ProductArray.self, from: data) - Пытаемся декодировать данные из модели ProductArray
   🔹 let products = - Если данные полученны и декодированны, загружаем их в константу  (let) products
 
 🟢 return products.products
   🔹 Первый products (белого цвета) - Это локальная константа, То есть: products  // ← объект типа ProductArray
   🔹 Второй products (бирюзового цвета) - Это свойство (property) внутри модели ProductArray.(находится в моей модели Product)
   ⚠️ products.products -> означает: «возьми у объекта products его свойство products»

 🔥Почему вообще одинаковые имена?
   Потому что: API возвращает JSON с ключом "products", а В Swift принято называть свойства так же, как в JSON
 
 🟡 Вторая функция делает тоже самое только для модели User
     */
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
       let (data , _ ) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
       let (data , _ ) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
}


  

