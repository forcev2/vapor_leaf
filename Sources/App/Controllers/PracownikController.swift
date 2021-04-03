import Fluent
import Vapor

struct PracownikController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func list(_ req: Request) throws -> EventLoopFuture<View> {
        let pracownicy = Pracownik.query(on: req.db).all()
        return pracownicy.flatMap { pracownicy in
            let data = ["Pracownicy": pracownicy]
            return req.view.render("pracownicy", data)
        }
    }

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let pracownik = try req.content.decode(Pracownik.self)
        return pracownik.save(on: req.db).map { _ in
            return req.redirect(to: "/pracownicy")
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let input = try req.content.decode(Pracownik.self)
        return Pracownik.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { pracownik in
                pracownik.osoba_id = input.osoba_id
                pracownik.praca = input.praca
                return pracownik.save(on: req.db).map { _ in
                    return req.redirect(to: "/pracownicy")
                }
            }
    }


    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Pracownik.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/pracownicy")
            }
    }
}