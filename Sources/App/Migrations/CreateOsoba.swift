import Foundation
import Fluent
import FluentSQLiteDriver

struct CreateOsoba: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("osoby")
        .id()
        .field("name", .string, .required)
        .field("surname", .string, .required)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("osoby").delete()
    }

}