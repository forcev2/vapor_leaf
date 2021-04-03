import Foundation
import Fluent
import FluentSQLiteDriver

struct CreatePracownik: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("pracownicy")
        .id()
        .field("osoba_id", .uuid, .required, .references("osoby", "id"))
        .foreignKey("osoba_id", references: "osoby", "id", onDelete: .cascade)
        .field("praca", .string)
        .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("pracownicy").delete()
    }

}