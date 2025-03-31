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


@MainActor
final class UsersViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var users: [UserData] = []
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
                users.append(contentsOf: pageData.data)
                state = .idle
            } catch {
                state = .error(error)
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
