import Combine
import SwiftUI

enum UserViewState: Equatable {
    static func == (lhs: UserViewState, rhs: UserViewState) -> Bool {
        return switch (lhs, rhs) {
        case (.idle, .idle): true
        case (.loading, .loading): true
        case (.error, .error): true
        default: false
        }
    }

    case idle
    case loading
    case error(Error)
}


final class UsersViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var users: [User.UserData] = []
    @Published var state: UserViewState = .idle
    let dataProvider: DP

    private var currentPage: Int = 1
    private var totalPages: Int = 0
    private var isMoreContent: Bool { currentPage <= totalPages || totalPages == 0 }

    init(dataProvider: DP) {
        self.dataProvider = dataProvider
        fetchUsers()
    }

    func fetchUsers() {
        guard state != .loading && isMoreContent else { return }
        state = .loading
        Task {
            do {
                let pageData = try await dataProvider.fetchUsers(forPage: currentPage)
                currentPage += 1
                totalPages = pageData.totalPages
                DispatchQueue.main.async { [weak self] in
                    self?.users.append(contentsOf: pageData.data)
                    self?.state = .idle
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.state = .error(error)
                }
            }
        }
    }

    func refresh() {
        guard state != .loading else { return }
        currentPage = 1
        users.removeAll()
        fetchUsers()
    }
}
