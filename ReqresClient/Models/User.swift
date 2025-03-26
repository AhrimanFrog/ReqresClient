import Foundation

struct User: Codable {
    struct UserData: Codable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String
    }

    struct Support: Codable {
        let text: String
    }

    let data: UserData
    let support: Support?
}
