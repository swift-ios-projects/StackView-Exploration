import UIKit

class PancakeHouseTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pancakeImage : UIImageView!
  @IBOutlet weak var ratingImage: UIImageView!

  
  var pancakeHouse : PancakeHouse? {
    didSet {
      if let pancakeHouse = pancakeHouse {
        nameLabel?.text = pancakeHouse.name
        pancakeImage?.image = pancakeHouse.thumbnail ?? UIImage(named: "placeholder_thumb")
        ratingImage?.image = pancakeHouse.rating.smallRatingImage
      }
    }
  }
}
