import Vapor
// 1
import PushNotifications
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // 2
    router.post(PushContent.self, at: "push/") { req, data -> String in
        do {
            try PushNotificationService.send(content: data)
            return "Push Success"
        } catch {
            return "Push Failed"
        }
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
    class func send(content: PushContent) throws {
        let pushNotifications = PushNotifications(instanceId: "YOUR_INSTANCE_ID" , secretKey:"YOUR_SECRET_KEY")
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
        try pushNotifications.publish(interests, publishRequest, completion: { publishID in
            print("Published \(publishID)")
        })
    }
}
