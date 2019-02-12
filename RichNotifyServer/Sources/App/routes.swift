import Vapor
// 1
import PushNotifications
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // 2
    router.post(PushContent.self, at: "push/") { req, data -> String in
        PushNotificationService.send(content: data)
        return "Push Success"
    }
}

// 4
struct PushContent: Content {
    let title: String
    let message: String
    let dataURL: String
}

//5
class PushNotificationService {
    // 6
    class func send(content: PushContent) {
        let pushNotifications = PushNotifications(instanceId: "9f9818f2-67e5-41d3-90ea-53efe135cccc" , secretKey:"62055D2E66DD6343408FD5F6DF18E83EE7ECC903ED03327DB89044B15277A935")
        let interests = ["general"]
        let publishRequest = [
            "apns": [
                "aps": [
                    "alert": [
                        "title": content.title,
                        "body": content.message
                    ],
                    "mutable-content": 1,
                    "category": "pusher"
                ],
                "data": [
                    "attachment-url": content.dataURL
                ]
            ]
        ]
        pushNotifications.publishToInterests(interests, publishRequest, completion: { publishID in
            print("Published \(publishID)")
        })
    }
}
