import Foundation

enum UserDefaultsKeys: String {
  case isSubscribed
  case weeklySubscriptionDetails
}

struct SubscriptionDetails: Codable {
    let price: String
    let period: String
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private init() {}

  static var isSubscribed: Bool {
    get {
      getValue(for: .isSubscribed) ?? true
    }

    set {
      setValue(value: newValue, for: .isSubscribed)
    }
  }
  static var weeklySubscriptionDetails: SubscriptionDetails? {
      get {
          if let data: Data = getValue(for: .weeklySubscriptionDetails) {
              return try? JSONDecoder().decode(SubscriptionDetails.self, from: data)
          }
          return nil
      }
      set {
          if let details = newValue,
             let data = try? JSONEncoder().encode(details) {
              setValue(value: data, for: .weeklySubscriptionDetails)
          }
      }
  }}

extension UserDefaultsManager {

    fileprivate static func setValue<T>(value: T, for key: UserDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    fileprivate static func getValue<T>(for key: UserDefaultsKeys) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
}
