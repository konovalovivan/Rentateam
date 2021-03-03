import Foundation

public enum Host {
    static let origin = "https://api.unsplash.com"
    enum photos {
        case `default`
        case random
        
        subscript(count: Int) -> String {
            rawValue + "?count=\(count)"
        }
        
        var rawValue: String {
            switch self {
            case .default:
                return Host.origin + "/photos"
            case .random:
                return Self.default.rawValue + "/random/"
            }
        }
    }
}
