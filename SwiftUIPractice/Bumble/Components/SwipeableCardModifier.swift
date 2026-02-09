//
//  SwipeableCardModifier.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 21.01.2026.
//
//🔴 Файл создан только для второй(альтернативной) версии BumbleHomeView 🔴

import SwiftUI

// MARK: - Swipeable Card Modifier (Bumble/Tinder style)

struct SwipeableCardModifier: ViewModifier {

    // Callbacks
    let onSwipeLeft: () -> Void
    let onSwipeRight: () -> Void

    // External state (for overlay indicators)
    @Binding var swipeOffset: CGFloat

    // Internal state
    @State private var dragOffset: CGSize = .zero
    @State private var isSwipingOut: Bool = false

    // Tuning constants
    private let distanceThreshold: CGFloat = 120
    private let velocityThreshold: CGFloat = 300
    private let offscreenX: CGFloat = 1000

    func body(content: Content) -> some View {
        content
            .offset(x: dragOffset.width)
            .rotationEffect(.degrees(Double(dragOffset.width / 14)))
            .gesture(dragGesture)
    }

    // MARK: - Drag Gesture

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                guard !isSwipingOut else { return }
                guard isHorizontal(value) else { return }

                dragOffset = value.translation
                swipeOffset = value.translation.width
            }
            .onEnded { value in
                guard !isSwipingOut else { return }
                guard isHorizontal(value) else {
                    reset()
                    return
                }

                let shouldSwipe =
                    abs(dragOffset.width) > distanceThreshold ||
                    abs(value.predictedEndTranslation.width) > velocityThreshold

                if shouldSwipe {
                    dragOffset.width > 0 ? swipeRight() : swipeLeft()
                } else {
                    reset()
                }
            }
    }

    // MARK: - Swipe Actions

    private func swipeRight() {
        swipeOut(to: offscreenX)
        onSwipeRight()
    }

    private func swipeLeft() {
        swipeOut(to: -offscreenX)
        onSwipeLeft()
    }

    private func swipeOut(to x: CGFloat) {
        isSwipingOut = true

        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            dragOffset.width = x
        }

        // Reset overlay state after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            swipeOffset = 0
            isSwipingOut = false
        }
    }

    // MARK: - Reset

    private func reset() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            dragOffset = .zero
        }
        swipeOffset = 0
    }

    // MARK: - Helpers

    private func isHorizontal(_ value: DragGesture.Value) -> Bool {
        abs(value.translation.width) > abs(value.translation.height)
    }
}

// MARK: - View Extension

extension View {
    func swipeable(
        swipeOffset: Binding<CGFloat>,
        onSwipeLeft: @escaping () -> Void,
        onSwipeRight: @escaping () -> Void
    ) -> some View {
        modifier(
            SwipeableCardModifier(
                onSwipeLeft: onSwipeLeft,
                onSwipeRight: onSwipeRight,
                swipeOffset: swipeOffset
            )
        )
    }
}

// MARK: - Preview

struct SwipeableCardPreview: View {

    @State private var swipeOffset: CGFloat = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(.orange)
            .frame(width: 300, height: 420)
            .overlay {
                Text("Swipe me 👉")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .swipeable(
                swipeOffset: $swipeOffset,
                onSwipeLeft: {
                    print("⬅️ Swiped left")
                },
                onSwipeRight: {
                    print("➡️ Swiped right")
                }
            )
            .padding()
    }
}

#Preview {
    SwipeableCardPreview()
}
