import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel

    var body: some View {
        List {
            ForEach(viewModel.users, id: \.data.id) { user in
                UserCell(source: user.data)
            }
            .onDelete(perform: viewModel.deleteUser(at:))
        }
        .onAppear { viewModel.updateUsers() }
    }
}

#Preview {
    FavoritesView(viewModel: .init(persistanceManager: try? .init()))
}
