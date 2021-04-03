import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateTowar: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("towary")
        .id()
        .field("name", .string, .required)
        .field("price", .int, .required)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("towary").delete()
    }

}