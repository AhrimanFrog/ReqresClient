import RealmSwift

final class UserObject: Object {
    @Persisted var data: UserDataObject?
    @Persisted var support: SupportObject?

    override init() {
        data = .init(userData: .example)
        support = .init(text: "")
        super.init()
    }

    init(data: UserData, support: Support) {
        self.data = .init(userData: data)
        self.support = .init(text: support.text)
    }
}
