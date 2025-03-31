import SwiftUI

@MainActor
final class Repository {
    enum ViewScreen {
        case users
        case details(UserData)
        case favorites
    }

    private let networkManager = NetworkManager()
    private let persistanceManger: PersistanceManager?

    static let shared = Repository()

    init() {
        persistanceManger = try? PersistanceManager()
    }

    func build(screen: ViewScreen) -> AnyView {
        switch screen {
        case .users:
            return AnyView(UsersView(viewModel: UsersViewModel(dataProvider: self.networkManager)))
        case .details(let userData):
            return AnyView(
                UserDetailsView(
                    viewModel: UserDetailsViewModel(
                        userDataProvider: networkManager,
                        persistanceManager: persistanceManger,
                        userData: userData
                    )
                )
            )
        case .favorites:
            return AnyView(FavoritesView(viewModel: FavoritesViewModel(persistanceManager: self.persistanceManger)))
        }
    }
}
