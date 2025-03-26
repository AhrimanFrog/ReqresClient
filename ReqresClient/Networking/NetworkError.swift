import Foundation

enum NetworkError: LocalizedError {
    case networkProblem
    case invalidData
    case badRequest
    case badResponse
    case wrongStatusCode(Int)

    var errorDescription: String {
        return switch self {
        case .networkProblem: "A network problem occured. Please, check your connection and try again"
        case .badRequest: "Could not fetch data. Please, try again"
        case .invalidData: "Could not decode data. Please, try again"
        case .badResponse: "Server error. Please, try again later"
        case .wrongStatusCode(let code): "Server returned error: \(code). Resource not found"
        }
    }

    var localizedDescription: String { errorDescription }
}
