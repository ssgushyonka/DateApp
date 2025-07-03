import Foundation

final class PayWallViewModel {
    let steps: [PayWallStep] = [
        PayWallStep(title: "Get 599 coins NOW and Every Week", imageName: "img-1"),
        PayWallStep(title: "Send Unlimited messages", imageName: "img-2"),
        PayWallStep(title: "turn off camera & sound", imageName: "img-3"),
        PayWallStep(title: "Mark your profile with VIP status", imageName: "img-4")
    ]

    var stepsCount: Int {
        steps.count
    }
}
