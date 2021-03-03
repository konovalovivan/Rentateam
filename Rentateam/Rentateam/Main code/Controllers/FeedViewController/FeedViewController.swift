import UIKit

class FeedViewController: UIViewController, PresentDelegate {
    
    private var feedView: FeedView!
    
    // Method for communication between FeedView and
    // controller to go to detail screen for photo post
    func postViewer(with post: FeedElement) {
        let vc: PostViewController = .shared
        vc.config(post: post)
        
        guard let nc = navigationController else {
            present(vc, animated: true)
            return
        }
        nc.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView = .init(frame: view.frame)
        feedView.model = .init(feedView, .shared)
        feedView.model?.updater(url: Host.photos.random[20])
        feedView.presentDelegate = self
        view.addSubview(feedView)
    }
}
