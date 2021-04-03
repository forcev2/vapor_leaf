import Fluent
import Vapor

struct TowarController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let towary = Towar.query(on: req.db).all()
        return towary.flatMap { towary in
            let data = ["Towary": towary]
            return req.view.render("towary", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let towar = try req.content.decode(Towar.self)
        return towar.save(on: req.db).map { _ in
            return req.redirect(to: "/towary")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Towar.self)
        return Towar.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { towar in
                towar.name = input.name
                towar.price = input.price
                return towar.save(on: req.db).map { _ in
                    return req.redirect(to: "/towary")
                }
            }
    }


    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Towar.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/towary")
            }
    }
}