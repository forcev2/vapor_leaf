import Fluent
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(
        .sqlite(.file("Sklep.db"))
        , as: .sqlite )


    app.migrations.add(CreateOsoba())
    app.migrations.add(CreatePracownik())
    app.migrations.add(CreateTowar())

    app.views.use(.leaf)

    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
