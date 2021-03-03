import UIKit

class FeedModel {
    
    private weak var feedView: UITableView?
    weak var storage: Storage?
    
    init(_ feedView: UITableView, _ storage: Storage) {
        self.feedView = feedView
        self.storage = storage
    }
    
    func updater(url: String? = nil) {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        feedView?.backgroundView = indicator
        
        func feedReload(bg view: UIView? = nil) {
            DispatchQueue.main.async { [weak feedView] in
                feedView?.backgroundView = view
                feedView?.reloadData()
            }
        }
        
        guard let url = url else {
            feedReload()
            return
        }
        
        API.get(to: url, with: { [self] in
            do {
                guard let data = try $0.get() else { fatalError("data nil") }
                Handler.work(with: data, storage) { [weak storage] (result: Result<Feed?,Error>) in
                    switch result {
                    case .success(let feed):
                        guard let feed = feed else { fatalError("feed nil") }
                        storage?.feed.setup(with: feed)
                        feedReload()
                    case .failure(let error):
                        print("DECODE_ERROR:", error.localizedDescription)
                        if let text = String(data: data, encoding: .utf8) {
                            // Here you can implement the functionality you need,
                            // for example, when you receive a message from the server about exceeding the request limit
                            print("🛑 failure:", text)
                        }
                    }
                }
            } catch {
                print("DATA_ERROR:", error.localizedDescription)
            }
        })
    }
}
