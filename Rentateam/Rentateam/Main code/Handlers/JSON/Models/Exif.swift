import Foundation

struct Exif: Codable {
    let make: String?
    let model: String?
    let exposure_time: String?
    let aperture: String?
    let focal_length: String?
    let iso: Int?
    
    enum CodingKeys: String, CodingKey {
        case make = "make"
        case model = "model"
        case exposure_time = "exposure_time"
        case aperture = "aperture"
        case focal_length = "focal_length"
        case iso = "iso"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        make = try values.decodeIfPresent(String.self, forKey: .make)
        model = try values.decodeIfPresent(String.self, forKey: .model)
        exposure_time = try values.decodeIfPresent(String.self, forKey: .exposure_time)
        aperture = try values.decodeIfPresent(String.self, forKey: .aperture)
        focal_length = try values.decodeIfPresent(String.self, forKey: .focal_length)
        iso = try values.decodeIfPresent(Int.self, forKey: .iso)
    }
}
