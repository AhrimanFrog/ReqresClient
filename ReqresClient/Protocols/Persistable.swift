import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: Object

    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
