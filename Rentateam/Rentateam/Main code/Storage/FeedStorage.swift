import Foundation

protocol FeedManager {
    var root: Feed { get }
    func add(post: FeedElement)
    func setup(with feed: Feed)
    func receive(post index: IndexPath) -> FeedElement?
    func remove(post: FeedElement)
}

//MARK: - Feed Storage Model -

class FeedStorage: FeedManager {
    
    private(set) var root: Feed = []
    
    func setup(with feed: Feed) {
        if root.isEmpty {
            self.root = feed
        } else {
            feed.forEach({ add(post: $0) })
        }
    }
    
    func receive(post index: IndexPath) -> FeedElement? {
        root[index.item]
    }
    
    func add(post: FeedElement) {
        root.append(post)
    }
    
    func remove(post: FeedElement) {
        // to implement this method, make FeedElement an NSObject
        // root = root.filter { $0 != post }
    }
}
