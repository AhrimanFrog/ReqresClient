import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel(dataProvider: NetworkManager())

    var body: some View {
        List(viewModel.users, id: \.id) { data in
            UserCell(source: data)
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}
