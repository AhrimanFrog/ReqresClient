import Foundation

protocol NetworkDataProvider {
    func fetchUsers(forPage page: Int) async throws -> PageData
    func getUserSupportText(byID userID: Int) async throws -> Support
}
