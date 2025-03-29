import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            UsersView()
                .tabItem { Label("Users", systemImage: "person.2.fill") }

            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "star.fill") }
        }
    }
}

#Preview {
    ContentView()
}
