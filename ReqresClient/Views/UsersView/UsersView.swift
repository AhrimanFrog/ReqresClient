import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel(dataProvider: NetworkManager())

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.users, id: \.id) { user in
                        UserCell(source: user)
                            .frame(width: 300, alignment: .leading)
                            .onAppear {
                                if user.id == viewModel.users.last?.id {
                                    viewModel.fetchUsers()
                                }
                            }
                            .onTapGesture {
                                print()
                            }
                    }
                }
            }
            .refreshable {
                viewModel.refresh()
            }
        }
    }
}
