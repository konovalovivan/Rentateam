import Foundation

public class ImageDataManager {
    static let shared = ImageDataManager()
    
    subscript(key: String, data: Data? = nil) -> Data? {
        get {
            return UserDefaults.standard.value(forKey: key) as? Data
        }
        set {
            return UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    fileprivate init() { }
}
