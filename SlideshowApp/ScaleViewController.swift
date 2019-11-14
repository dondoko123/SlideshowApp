import UIKit

class ScaleViewController: UIViewController {
    
    @IBOutlet var scaledImage: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scaledImage.image = image
    }
}
