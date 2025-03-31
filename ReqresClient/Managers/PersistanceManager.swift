import Foundation
import RealmSwift

class PersistanceManager {
    private let realm: Realm

    init() throws {
        realm = try Realm()
    }
}
