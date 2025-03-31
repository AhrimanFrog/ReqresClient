import Combine
import Foundation

final class UserDetailsViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var userData: UserData
    @Published var supportText: Support = .init(text: "Loading...")

    init(userDataProvider: DP, userData: UserData) {
        self.userData = userData
        Task { [weak self] in
            let text = try await userDataProvider.getUserSupportText(byID: userData.id)
            DispatchQueue.main.async { self?.supportText = text }
        }
    }
}
