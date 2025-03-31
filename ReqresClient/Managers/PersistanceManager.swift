import Foundation
import RealmSwift

class PersistanceManager {
    private let realm: Realm

    convenience init() throws {
        try self.init(realm: Realm())
    }

    init(realm: Realm) {
        self.realm = realm
    }

    func add(newUser: User) throws {
        try realm.write { realm.add(newUser.managedObject()) }
    }

    func getUsers() -> [User] {
        return realm.objects(UserObject.self).map { .init(managedObject: $0) }
    }

    func remove(user: User) throws {
        guard let realmUser = realm.objects(UserObject.self).first(where: { $0.data?.id == user.data.id }) else {
            return
        }
        try realm.write { realm.delete(realmUser) }
    }
}
