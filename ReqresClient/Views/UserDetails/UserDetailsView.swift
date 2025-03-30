import SwiftUI

struct UserDetailsView: View {
    private let viewModel: UserDetailsViewModel<NetworkManager>

    init(networkManager: NetworkManager, userID: Int) {
        self.viewModel = .init(userDataProvider: networkManager, userID: userID)
    }

    var body: some View {
        Text("KUK")
    }
}
