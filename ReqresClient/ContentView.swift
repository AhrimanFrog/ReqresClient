import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Users", systemImage: "person.2.fill") {
                UsersView()
            }
            Tab("Favorites", systemImage: "star.fill") {
                FavoritesView()
            }
        }
    }
}

#Preview {
    ContentView()
}
