import Foundation
import Fluent
import Vapor


final class Osoba: Model, Content {

    static let schema = "osoby"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "surname")
    var surname: String

    init() {}

    init(id: UUID? = nil, name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
    }

} 