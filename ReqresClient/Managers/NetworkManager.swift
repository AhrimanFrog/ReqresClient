import UIKit

class NetworkManager: NetworkDataProvider {
    private let endpoint = "https://reqres.in/api/users"
    private let decoder = JSONDecoder()
    private let cache = NSCache<NSString, UIImage>()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetchUsers(forPage page: Int) async throws -> PageData {
        return try await fetchData(request: endpoint + "?page=\(page)", type: PageData.self)
    }

    func getUserInfo(byID userID: Int) async throws -> User {
        return try await fetchData(request: endpoint + "/\(userID)", type: User.self)
    }

    private func fetchData<T: Codable>(request: String, type: T.Type) async throws -> T {
        guard let url = URL(string: request) else { throw NetworkError.invalidData }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = (response as? HTTPURLResponse) else { throw NetworkError.badResponse }
        guard httpResponse.statusCode == 200 else { throw NetworkError.wrongStatusCode(httpResponse.statusCode) }
        return try decoder.decode(type, from: data)
    }
}
