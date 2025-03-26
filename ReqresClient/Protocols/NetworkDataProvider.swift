import Foundation

protocol NetworkDataProvider {
    func fetchUsers(forPage page: Int) async throws -> PageData
    func getUserInfo(byID userID: Int) async throws -> User
}
