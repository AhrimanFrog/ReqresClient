import RealmSwift

struct Support: Codable {
    let text: String
}

extension Support: Persistable {
    init(managedObject: SupportObject) {
        text = managedObject.text
    }

    func managedObject() -> SupportObject {
        return SupportObject(text: text)
    }
}

final class SupportObject: Object {
    @Persisted var text: String

    override init() {
        text = ""
    }

    init(text: String) {
        self.text = text
    }
}
