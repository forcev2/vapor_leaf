import Foundation
import Fluent
import Vapor


final class Pracownik: Model, Content {

    static let schema = "pracownicy"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "osoba_id")
    var osoba_id: UUID

    @Field(key: "praca")
    var praca: String

    init() {}

    init(id: UUID? = nil, osoba_id: String, praca: String) {
        self.id = id
        self.osoba_id = UUID(uuidString: osoba_id)!
        self.praca = praca
    }

} 