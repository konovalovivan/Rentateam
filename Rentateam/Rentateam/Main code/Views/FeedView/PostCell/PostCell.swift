import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var backgroundBlurView: UIVisualEffectView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var downloadCountLabel: UILabel!
    
    
    func config(info post: FeedElement, img data: Data?) {
        previewImageView.image = data != nil ? UIImage(data: data!) : UIImage(named: "brokenImage")
        bgBlurImage(with: previewImageView.image, bv: backgroundBlurView)
        
        if let text = post.feedDescription, text.count > 0 {
            titleLabel.text = text
        } else if let text = post.altDescription, text.count > 0 {
            titleLabel.text = text
        } else {
            titleLabel.text = "Untitled"
        }
        
        usernameLabel.text = post.user?.username
        likesCountLabel.text = (post.likes ?? 0).description
        viewsCountLabel.text = (post.views ?? 0).description
        downloadCountLabel.text = (post.downloads ?? 0).description
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
