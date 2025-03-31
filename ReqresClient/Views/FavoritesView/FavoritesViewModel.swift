import Combine
import Foundation

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var users: [User] = []

    private let persistanceManager: PersistanceManager?

    init(persistanceManager: PersistanceManager?) {
        self.persistanceManager = persistanceManager
    }

    func updateUsers() {
        users = persistanceManager?.getUsers() ?? []
    }

    func deleteUser(at offsets: IndexSet) {
        let usersToDelete = offsets.compactMap { users.indices.contains($0) ? users[$0] : nil }
        users.remove(atOffsets: offsets)
        usersToDelete.forEach { try? persistanceManager?.remove(user: $0) }
    }
}
