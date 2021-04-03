import Fluent
import Vapor

func routes(_ app: Application) throws {


    app.get("") { req -> EventLoopFuture<View> in
        return req.view.render("index", ["title": "index"])
    }

    //Osoba
    let osobaController = OsobaController()
    app.get("osoby", use: osobaController.list) 
    app.post("osoba", "create", use: osobaController.create)
    app.post("osoba", "update", ":id", use: osobaController.update)
    app.post("osoba", "delete", ":id", use: osobaController.delete)
    

    //Towar
    let towarController = TowarController()
    app.get("towary", use: towarController.list)  
    app.post("towar", "create", use: towarController.create)
    app.post("towar", "update", ":id", use: towarController.update)
    app.post("towar", "delete", ":id", use: towarController.delete)


    //Pracownik
    let pracownikController = PracownikController()
    app.get("pracownicy", use: pracownikController.list) 
    app.post("pracownik", "create", use: pracownikController.create)
    app.post("pracownik", "update", ":id", use: pracownikController.update)
    app.post("pracownik", "delete", ":id", use: pracownikController.delete)
    
}
