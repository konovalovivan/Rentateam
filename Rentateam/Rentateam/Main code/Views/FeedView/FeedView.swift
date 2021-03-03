import UIKit

protocol PresentDelegate: class {
    func postViewer(with post: FeedElement)
}

class FeedView: UITableView {
    
    var model: FeedModel?
    weak var presentDelegate: PresentDelegate?
    
    fileprivate func setup() {
        register(PostCell.nib, forCellReuseIdentifier: PostCell.id)
        delegate = self
        dataSource = self
        decelerationRate = .fast
        
        rowHeight = frame.standardized.width / 3
        estimatedRowHeight = frame.standardized.width / 3
        
        let i = separatorInset.left
        separatorInset = .init(top: 0, left: i, bottom: 0, right: i)
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, style: .plain)
        self.setup()
    }
}

//MARK: - FeedView's Table View -

extension FeedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.storage?.feed.root.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as! PostCell
        guard let storage = model?.storage else { fatalError() }
        if let post = storage.feed.receive(post: indexPath) {
            cell.config(info: post, img: storage.images[post.id])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = model?.storage?.feed.root.count, indexPath.row == (results - 10) else { return }
        // Method for uploading a new batch of photos when the specified index is reached
        model?.updater(url: Host.photos.random[20])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let storage = model?.storage else { fatalError() }
        if let post = storage.feed.receive(post: indexPath) {
            self.presentDelegate?.postViewer(with: post)
        }
    }
}
