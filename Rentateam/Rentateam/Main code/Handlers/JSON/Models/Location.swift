import Foundation

struct Location: Codable {
    let title: String?
    let name: String?
    let city: String?
    let country: String?
    let position: Position?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case name = "name"
        case city = "city"
        case country = "country"
        case position = "position"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        position = try values.decodeIfPresent(Position.self, forKey: .position)
    }
}
