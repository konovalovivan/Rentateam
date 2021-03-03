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
        
        func feedReloader(bg view: UIView? = nil) {
            DispatchQueue.main.async { [weak feedView] in
                feedView?.backgroundView = view
                feedView?.reloadData()
            }
        }
        
        guard let url = url else {
            feedReloader()
            return
        }
        
        func worker(with data: Data) {
            Handler.work(with: data, storage) { [weak storage] (result: Result<Feed?,Error>) in
                switch result {
                case .success(let feed):
                    guard let feed = feed else { fatalError("feed nil") }
                    storage?.feed.setup(with: feed)
                    feedReloader()
                case .failure(let error):
                    print("DECODE_ERROR:", error.localizedDescription)
                    if let text = String(data: data, encoding: .utf8) {
                        // Here you can implement the functionality you need,
                        // for example, when you receive a message from the server about exceeding the request limit
                        print("🟡 WARNING:", text)
                    }
                }
            }
        }
        
        API.get(to: url, with: { [self] in
            do {
                guard let data = try $0.get() else { fatalError("data nil") }
                storage?.dataStorage.append(data)
                worker(with: data)
            } catch {
                print("🛑 CONNECTION FAILED!!!", error.localizedDescription)
                
                // MARK: Retrieving stored data from UserDefaults
                // Everything works perfectly!
                guard let key = storage?.dataBackupKey,
                      let datas: [Data] = storage?.dataBackup[key] else { return }
                for data in datas {
                    DispatchQueue.global(qos: .background).async {
                        worker(with: data)
                    }
                }
            }
        })
    }
}
