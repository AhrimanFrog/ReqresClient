import Combine
import Foundation

@MainActor
final class UserDetailsViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var userData: UserData
    @Published var supportText: Support = .init(text: "Loading...")
    private let persistanceManager: PersistanceManager?
    private let dataProvider: DP

    init(userDataProvider: DP, persistanceManager: PersistanceManager?, userData: UserData) {
        dataProvider = userDataProvider
        self.userData = userData
        self.persistanceManager = persistanceManager
    }

    func updateText() async {
        supportText = (try? await dataProvider.getUserSupportText(byID: userData.id)) ?? .init(text: "No text")
    }

    func userIsFavored() -> Bool {
        return persistanceManager?.getUsers().contains { $0.data.id == userData.id } ?? false
    }

    func persistUserInDatabase(new: Bool) {
        let user = User(data: userData, support: supportText)
        if new {
            try? persistanceManager?.add(newUser: user)
        } else {
            try? persistanceManager?.remove(user: user)
        }
    }
}
