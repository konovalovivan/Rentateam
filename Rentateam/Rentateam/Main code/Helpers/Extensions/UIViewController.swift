import UIKit.UIViewController

extension UIViewController {
    static var id: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: id, bundle: nil) }
    static var shared: Self { nib.instantiate(withOwner: nil, options: nil)[0] as! Self }
}
