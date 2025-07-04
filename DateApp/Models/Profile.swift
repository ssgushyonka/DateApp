import Foundation

struct Profile: Decodable {
    let name: String
    let age: Int
    let country: String
    let imageURL: URL?
    let isOnline: Bool
    
    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case country
        case imageURL = "image_url"
        case isOnline = "is_online"
    }
}
