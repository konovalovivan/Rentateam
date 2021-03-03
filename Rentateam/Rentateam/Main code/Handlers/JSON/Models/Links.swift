import Foundation

struct Links: Codable {
    var linksSelf, html, photos, likes, portfolio, following, followers: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        linksSelf = try values.decodeIfPresent(String.self, forKey: .linksSelf)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        photos = try values.decodeIfPresent(String.self, forKey: .photos)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        portfolio = try values.decodeIfPresent(String.self, forKey: .portfolio)
        following = try values.decodeIfPresent(String.self, forKey: .following)
        followers = try values.decodeIfPresent(String.self, forKey: .followers)
    }
}
