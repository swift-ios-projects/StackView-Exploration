import UIKit
import MapKit

class PancakeHouseViewController : UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceGuideLabel: UILabel!
  @IBOutlet weak var ratingImage: UIImageView!
  @IBOutlet weak var showDetailsButton: UIButton!


  var pancakeHouse : PancakeHouse? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let pancakeHouse = pancakeHouse {
      nameLabel?.text = pancakeHouse.name
      imageView?.image = pancakeHouse.photo ?? UIImage(named: "placeholder")
      detailsLabel?.text = pancakeHouse.details
      priceGuideLabel?.text = "\(pancakeHouse.priceGuide)"
      ratingImage?.image = pancakeHouse.rating.ratingImage
      centreMap(mapView, atPosition: pancakeHouse.location)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
  
  @IBAction func handleShowDetailsButtonPressed(sender: UIButton) {

  }
  
  
  private func centreMap(map: MKMapView?, atPosition position: CLLocationCoordinate2D?) {
    guard let map = map,
      let position = position else {
        return
    }
    map.zoomEnabled = false
    map.scrollEnabled = false
    map.pitchEnabled = false
    map.rotateEnabled = false
    
    map.setCenterCoordinate(position, animated: true)
    
    let zoomRegion = MKCoordinateRegionMakeWithDistance(position, 10000, 10000)
    map.setRegion(zoomRegion, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = position
    map.addAnnotation(annotation)
    
  }

}

