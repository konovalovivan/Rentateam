import Foundation

public class Storage {
    
    static let shared = Storage()
    
    let feed: FeedStorage
    let images: ImageDataManager
    
    fileprivate init() {
        feed = .init()
        images = .shared
    }
}
