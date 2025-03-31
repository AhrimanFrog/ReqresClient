import RealmSwift

struct UserData: Codable, Hashable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String

    var fullName: String { "\(firstName) \(lastName)" }

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

extension UserData: Persistable {
    init(managedObject: UserDataObject) {
        id = managedObject.id
        email = managedObject.email
        firstName = managedObject.firstName
        lastName = managedObject.lastName
        avatar = managedObject.avatar
    }

    func managedObject() -> UserDataObject {
        return UserDataObject(userData: self)
    }
}

class UserDataObject: Object {
    @Persisted var id: Int
    @Persisted var email: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var avatar: String

    override init() {
        id = 0
        email = ""
        firstName = ""
        lastName = ""
        avatar = ""
    }

    init(userData: UserData) {
        id = userData.id
        email = userData.email
        firstName = userData.firstName
        lastName = userData.lastName
        avatar = userData.avatar
    }
}
