import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("hello",":name") { request in
    if let name = request.parameters["name"]?.string {
        return "Hello \(name)!"
    }
    return "Error retrieving parameters."
}

drop.get("hello") { req in
    return JSON([
        "message" : "hello"
        ]
    )
}

drop.post("hello") { req in
    guard let name = req.data["name"]?.string else {
        throw Abort.badRequest
    }
    return try JSON(node: [
            "hello, \(name)"
        ]
    )
}

drop.post("hello") { req in
    guard let name = req.data["name"]?.string else {
        throw Abort.badRequest
    }
    return try JSON(node: [
        "hello, \(name)"
        ]
    )
}

drop.resource("posts", PostController())

drop.run()
