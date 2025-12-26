//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//
import UIKit
import SwiftUI
import SwiftfulRouting


@main
struct SwiftUIPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView() { _ in
                ContentView()
            }
            
        }
    }
}


//❕Расширение контроллера навигации(по сути это стек навигации), он позволяет обратным свайпом вернуться на предыдуший экран. Поумолчанию он не работает в SwiftUI   (на желтую ошибку не обрашать внимания)

extension UINavigationController: UIGestureRecognizerDelegate {
    
    // Разрешаем свайп назад всегда
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    // Разрешаем жест, если есть, куда возвращаться
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
