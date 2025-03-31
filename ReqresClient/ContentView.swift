import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Repository.shared.build(screen: .users)
                .tabItem { Label("Users", systemImage: "person.2.fill") }

            Repository.shared.build(screen: .favorites)
                .tabItem { Label("Favorites", systemImage: "star.fill") }
        }
    }
}

#Preview {
    ContentView()
}
