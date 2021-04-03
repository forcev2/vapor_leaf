import Foundation
import Fluent
import Vapor


final class Towar: Model, Content {

    static let schema = "towary"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "price")
    var price: Int

    init() {}

    init(id: UUID? = nil, name: String, price: Int) {
        self.id = id
        self.name = name
        self.price = price
    }

} 