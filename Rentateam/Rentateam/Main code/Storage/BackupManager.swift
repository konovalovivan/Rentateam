import Foundation

public class BackupManager {
    static let shared = BackupManager()
    
    subscript<T>(key: String, data: T? = nil) -> T? {
        get {
            return UserDefaults.standard.value(forKey: key) as? T
        }
        set {
            return UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
    
    fileprivate init() { }
}
