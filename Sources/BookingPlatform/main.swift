import Kitura
import HeliumLogger

HeliumLogger.use()

let apiController = ApiController()

Kitura.addHTTPServer(onPort: 8090, with: apiController.router)
Kitura.run()
