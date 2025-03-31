import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailsViewModel<NetworkManager>
    @State var isFavored: Bool = false

    init(viewModel: UserDetailsViewModel<NetworkManager>) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
            .task { await viewModel.updateText() }
        Spacer()
        FavorButton(isFavored: $isFavored) { favored in
            viewModel.persistUserInDatabase(new: favored)
        }
        .onAppear { isFavored = viewModel.userIsFavored() }
        Spacer()
    }
}
