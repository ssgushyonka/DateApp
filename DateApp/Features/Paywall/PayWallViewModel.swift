import Foundation

final class PayWallViewModel {
    let steps: [PayWallStep] = [
        PayWallStep(title: "Get 599 coins NOW And Every Week", imageName: "img-1"),
        PayWallStep(title: "Send Unlimited messages", imageName: "img-2"),
        PayWallStep(title: "Turn Off Camera & Sound", imageName: "img-3"),
        PayWallStep(title: "Mark your profile with VIP Status", imageName: "img-4")
    ]

    var stepsCount: Int {
        steps.count
    }
}
