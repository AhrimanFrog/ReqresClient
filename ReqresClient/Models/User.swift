import Foundation

struct User: Codable {
    struct UserData: Codable, Hashable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String

        static var example: UserData {
            .init(
                id: 1,
                email: "kuk.con",
                firstName: "Kuk",
                lastName: "ivanovich",
                avatar: "https://reqres.in/img/faces/8-image.jpg"
            )
        }
    }

    struct Support: Codable {
        let text: String
    }

    let data: UserData
    let support: Support?
}
