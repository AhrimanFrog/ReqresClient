import SwiftUI

struct UsersView: View {
    @StateObject private var viewModel = UsersViewModel(dataProvider: NetworkManager.shared)
    @State private var showingAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            UsersList(data: viewModel.users, state: viewModel.state) { userID in
                if viewModel.users.last?.id == userID {
                    viewModel.fetchUsers()
                }
            }
            .onReceive(viewModel.$state) { newState in
                switch newState {
                case .error(let error):
                    showingAlert = true
                    errorMessage = error.localizedDescription
                default:
                    showingAlert = false
                    errorMessage = ""
                }
            }
        }
        .alert(
            "Oops!",
            isPresented: $showingAlert,
            actions: { Button("OK", role: .cancel) { showingAlert = false } },
            message: { Text(errorMessage) }
        )
        .refreshable {
            viewModel.refresh()
        }
    }
}
