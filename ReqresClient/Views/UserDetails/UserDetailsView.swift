import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailsViewModel<NetworkManager>
    private let userData: UserData

    init(networkManager: NetworkManager, data: UserData) {
        _viewModel = StateObject(
            wrappedValue: UserDetailsViewModel(userDataProvider: networkManager, userData: data)
        )
        userData = data
    }

    var body: some View {
        UserImage(source: viewModel.userData.avatar)
            .frame(width: 100, height: 100)
        Text(viewModel.userData.fullName)
            .foregroundStyle(.primary)
        Text(viewModel.userData.email)
            .foregroundStyle(.secondary)
        Text(viewModel.supportText.text)
            .frame(alignment: .center)
            .font(.title3)
            .padding(.horizontal)
            .offset(.init(width: 0, height: 50))
        Spacer()
        FavorButton(isFavored: viewModel.userIsFavored(data: userData)) { favored in
            viewModel.persistUserInDatabase(new: favored)
        }
        Spacer()
    }
}

#Preview {
    UserDetailsView(networkManager: .shared, data: .example)
}
