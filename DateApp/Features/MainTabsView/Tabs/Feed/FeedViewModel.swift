import Foundation

final class FeedViewModel {
    private let provider: ProfilesProvider
    private var profiles: [Profile] = []
    
    var onProfilesUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(provider: ProfilesProvider = ProfilesProvider()) {
        self.provider = provider
    }
    
    func loadProfiles() {
        provider.getProfiles { [weak self] result in
            switch result {
            case .success(let profiles):
                self?.profiles = profiles
                print("profiles count:", profiles.count)
                self?.onProfilesUpdated?()
            case .failure(let error):
                print("error:", error.localizedDescription)
                self?.onError?(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return profiles.count
    }
    
    func profile(at index: Int) -> Profile {
        return profiles[index]
    }
}
