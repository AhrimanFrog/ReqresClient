import Combine
import Foundation

final class UserDetailsViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var userData: UserData
    @Published var supportText: Support = .init(text: "Loading...")
    private let persistanceManager: PersistanceManager

    init(userDataProvider: DP, userData: UserData) {
        self.userData = userData
        self.persistanceManager = try! PersistanceManager()
        Task { [weak self] in
            let text = try await userDataProvider.getUserSupportText(byID: userData.id)
            DispatchQueue.main.async { self?.supportText = text }
        }
    }

    func userIsFavored(data: UserData) -> Bool {
        return persistanceManager.getUsers().contains { $0.data.id == data.id }
    }

    func persistUserInDatabase(new: Bool) {
        let user = User(data: userData, support: supportText)
        if new {
            try? persistanceManager.add(newUser: user)
        } else {
            try? persistanceManager.remove(user: user)
        }
    }
}
