import Kitura
import HeliumLogger

HeliumLogger.use()

let router = Router()
router.get { request, response, next in
    defer { next() }
    
    response.send("It working!")
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
