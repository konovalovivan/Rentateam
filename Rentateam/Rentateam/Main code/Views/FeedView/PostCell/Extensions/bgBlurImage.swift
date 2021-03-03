import UIKit

extension UIView {
    func bgBlurImage(with image: UIImage?, bv blurView: UIVisualEffectView) {
        UIGraphicsBeginImageContext(blurView.frame.size)
        image?.draw(in: blurView.bounds)
        if let imageContext = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            blurView.backgroundColor = UIColor(patternImage: imageContext)
        }
    }
}
