import Foundation
import StoreKit
import ApphudSDK

final class SubscriptionManager {
  static let shared = SubscriptionManager()

  var trialProduct: ApphudProduct?
  private var purchaseCompletion: ((Bool) -> Void)?

  func isSubscribed(completion: @escaping ((Bool) -> Void)) {
    let isSubscribed = Apphud.hasActiveSubscription()
    completion(isSubscribed)
  }

  @MainActor func getProducts() {
    Apphud.paywallsDidLoadCallback { [weak self] paywalls, _ in
      if let paywall = paywalls.first(where: { $0.identifier == "paywall1" }) {

        self?.trialProduct = paywall.products.first(where: { $0.productId.contains("week.trial") })
      }

      if let weeklyProduct = self?.trialProduct?.skProduct {
          let details = SubscriptionDetails(
            price: weeklyProduct.localizedPrice,
              period: "week"
          )
          UserDefaultsManager.weeklySubscriptionDetails = details
      }
    }
  }

  @MainActor func buySubscription(_ product: ApphudProduct, completion: @escaping (Bool) -> Void) {
    purchaseCompletion = completion

    Apphud.purchase(product) { [weak self] result in
      DispatchQueue.main.async {
        let isSubscribed = Apphud.hasActiveSubscription()
        UserDefaultsManager.isSubscribed = isSubscribed

        self?.purchaseCompletion?(isSubscribed)
        self?.purchaseCompletion = nil
      }
    }
  }

  @MainActor func restorePurchase() async -> Bool {
    do {
      try await AppStore.sync()
      let isSubscribed = Apphud.hasActiveSubscription()
      DispatchQueue.main.async {
        UserDefaultsManager.isSubscribed = isSubscribed
      }
      return isSubscribed
    } catch {
      print("Restore failed: \(error)")
      return false
    }
  }
}
extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price) ?? ""
    }
}
