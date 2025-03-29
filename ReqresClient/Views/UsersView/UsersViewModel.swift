import Combine
import SwiftUI

final class UsersViewModel<DP: NetworkDataProvider>: ObservableObject {
    @Published var users: [User.UserData] = []
    let errorNotifier = PassthroughSubject<any Error, Never>()

    private var queue = DispatchQueue(label: "users.queue", attributes: .concurrent)
    private var currentPage: Int = 1
    private let dataProvider: DP
    private var totalPages: Int = 0
    private var isLoading = false

    init(dataProvider: DP) {
        self.dataProvider = dataProvider
        fetchUsers()
    }

    private var isMoreContent: Bool { currentPage <= totalPages || totalPages == 0 }

    func fetchUsers() {
        guard !isLoading && isMoreContent else { return }
        isLoading.toggle()
        Task {
            do {
                let pageData = try await dataProvider.fetchUsers(forPage: currentPage)
                currentPage += 1
                totalPages = pageData.totalPages
                DispatchQueue.main.async { [weak self] in self?.users.append(contentsOf: pageData.data) }
            } catch {
                print(error.localizedDescription)
                errorNotifier.send(error)
            }
            isLoading.toggle()
        }
    }

    func refresh() {
        guard !isLoading else { return }
        currentPage = 1
        users.removeAll()
        fetchUsers()
    }
}
