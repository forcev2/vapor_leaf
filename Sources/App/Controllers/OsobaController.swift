import Fluent
import Vapor

struct OsobaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let osoby = Osoba.query(on: req.db).all()
        return osoby.flatMap { osoby in
            let data = ["Osoby": osoby]
            return req.view.render("osoby", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let osoba = try req.content.decode(Osoba.self)
        return osoba.save(on: req.db).map { _ in
            return req.redirect(to: "/osoby")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Osoba.self)
        return Osoba.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { osoba in
                osoba.name = input.name
                osoba.surname = input.surname
                return osoba.save(on: req.db).map { _ in
                    return req.redirect(to: "/osoby")
                }
            }
    }


    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Osoba.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/osoby")
            }
    }
}