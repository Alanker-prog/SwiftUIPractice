# ✴️ SwiftUI Practice — Netflix · Bumble · Spotify

> 🔹 A multi-app iOS project built to practice real-world SwiftUI architecture, networking, and component design.

---

## 🟢 Apps Included

- 🎬 **Netflix Clone** — Browse products with hero cell, category rows, filter bar, and detail screen
- 💬 **Bumble Clone** — Swipe-based card UI with user profiles and match interaction
- 🎵 **Spotify Clone** — Music browsing UI with playlists, artists, and now-playing screen

All three apps share a common **NetworkService**, **data models**, and **architecture**.

---

## 🟢 Screenshots

### 🎬 Netflix
<p float="left">
<img width="200" src="https://github.com/user-attachments/assets/923c809b-2ac8-4fd7-bf7d-6d9b7dccc561" />
<img width="200" src="https://github.com/user-attachments/assets/4b3267dc-7000-4539-8869-926918bc8223" />
</p>

### 🎵 Spotify
<p float="left">
<img width="200" src="https://github.com/user-attachments/assets/70829040-c033-400e-8056-221a8f0e7557" />
<img width="200" src="https://github.com/user-attachments/assets/88c745ce-ba02-496f-bede-ff9dd705fd04" />
</p>

### 💬 Bumble
<p float="left">
<img width="200" src="https://github.com/user-attachments/assets/233be6c4-fead-4342-bf38-2a01f9dfccfa" />
<img width="200" src="https://github.com/user-attachments/assets/affeb666-1f18-4ab4-842c-2c4220afac8c" />
</p>

---

## 🟢 Tech Stack

- ◉ **Language** — Swift 5.9+
- ◉ **UI Framework** — SwiftUI
- ◉ **Architecture** — MVVM
- ◉ **Concurrency** — async/await, Task, MainActor
- ◉ **Networking** — URLSession, REST API
- ◉ **Image Loading** — SDWebImageSwiftUI
- ◉ **Navigation** — SwiftfulRouting
- ◉ **Dependency Mgmt** — Swift Package Manager (SPM)
- ◉ **Version Control** — Git / GitHub

---

## 🟢 Architecture

The project follows a **modular MVVM** structure. Each app is self-contained with shared infrastructure.

```
SwiftUIPractice/
├── Netflix/
│   ├── Core/
│   │   ├── NetflixHomeView.swift
│   │   ├── NetflixHomeViewModel.swift
│   │   ├── NetflixMovieDetailsView.swift
│   │   └── NetflixMovieDetailsViewModel.swift
│   └── Components/
│       ├── NetflixHeroCell.swift
│       ├── NetflixMovieCell.swift
│       └── NetflixFilterCell.swift
├── Bumble/
├── Spotify/
└── Shared/
    ├── NetworkService.swift
    ├── DatabaseHelper.swift
    ├── ImageLoaderView.swift
    ├── Product.swift
    └── User.swift
```

---

## 🟢 Networking

A single shared `NetworkService` is used across all apps. Built with scalability in mind.

```swift
// Adding a new endpoint takes one line
func getCategories() async throws -> [Category] {
    try await fetch(Category.self, endpoint: "/categories")
}
```

**Features:**
- Generic `fetch<T: Decodable>` — no code duplication per model
- `Endpoint` enum — type-safe routes, no raw strings
- `PagedResponse<T>` — universal wrapper with `DynamicKey` for any JSON shape
- `convertFromSnakeCase` — automatic `first_name` → `firstName` mapping
- HTTP status validation — 4xx / 5xx throw typed errors
- Dependency Injection via `URLSession` — easy to mock in tests

---

## 🟢 Reusable Components

UI components are designed to be **data-agnostic** — they receive only what they need and communicate back via callbacks.

```swift
NetflixHeroCell(
    imageName: product.firstImage,
    title: product.title,
    categories: product.categoriesDisplay
) {
    onPlayTap?()
} onMyListTap: {
    onMyListTap?()
}
```

- No direct model dependencies inside cells
- Actions via optional closures `(() -> Void)?`
- Reusable across multiple screens and apps

---

## 🟢 Key Concepts Practiced

- **MVVM** — clean separation of View and business logic
- **async/await** — modern concurrency without callbacks
- **@MainActor** — safe UI updates from async context
- **Task lifecycle** — cancel on deinit, weak self, `isCancelled` checks
- **Generics** — reusable network layer with `fetch<T>`
- **Protocols** — `NetworkServiceProtocol` for testability
- **Dependency Injection** — `URLSession` injected via init

---

## 📦 Installation

```bash
git clone https://github.com/Alanker-prog/SwiftUIPractice.git
cd SwiftUIPractice
open SwiftUIPractice.xcodeproj
```

Build and run in Xcode 15+ on iOS 17+ simulator or device.

---

## 🟢 Future Improvements

- [ ] Pagination support (`skip` / `limit`)
- [ ] Response caching
- [ ] Unit tests with mock `URLSession`
- [ ] Error state UI (empty states, retry buttons)
- [ ] Accessibility support (VoiceOver, Dynamic Type)

---

## 👨‍💻 Author

**Alan Parastaev** — iOS Developer  
GitHub: [@Alanker-prog](https://github.com/Alanker-prog)
