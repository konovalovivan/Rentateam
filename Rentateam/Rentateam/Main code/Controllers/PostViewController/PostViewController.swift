import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgBlurPhoto: UIVisualEffectView!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var downloadCountLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    func config(post: FeedElement) {
        
        let imd = Storage.shared.images[post.id] // image data
        imageView.image = imd != nil ? UIImage(data: imd!) : UIImage(named: "brokenImage")
        view.bgBlurImage(with: imageView.image, bv: bgBlurPhoto) // Create a blur effect under the photo
        
        likesCountLabel.text = (post.likes ?? 0).description
        viewsCountLabel.text = (post.views ?? 0).description
        downloadCountLabel.text = (post.downloads ?? 0).description
        
        // MARK: Required metadata
        createdAtLabel.text = post.created_at
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
