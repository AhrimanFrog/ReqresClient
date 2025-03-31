struct User: Codable {
    let data: UserData
    let support: Support
}

extension User: Persistable {
    init(managedObject: UserObject) {
        data = .init(managedObject: managedObject.data!)
        support = .init(managedObject: managedObject.support!)
    }

    func managedObject() -> UserObject {
        return UserObject(data: data, support: support)
    }
}
