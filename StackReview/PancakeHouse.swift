import UIKit
import CoreLocation

enum PriceGuide : Int {
  case Unknown = 0
  case Low = 1
  case Medium = 2
  case High = 3
}

extension PriceGuide : CustomStringConvertible {
  var description : String {
    switch self {
    case .Unknown:
      return "?"
    case .Low:
      return "$"
    case .Medium:
      return "$$"
    case .High:
      return "$$$"
    }
  }
}

enum PancakeRating {
  case Unknown
  case Rating(Int)
}

extension PancakeRating {
  init?(value: Int) {
    if value > 0 && value <= 5 {
      self = .Rating(value)
    } else {
      self = .Unknown
    }
  }
}

extension PancakeRating {
  var ratingImage : UIImage? {
    guard let baseName = ratingImageName else {
      return nil
    }
    return UIImage(named: baseName)
  }
  
  var smallRatingImage : UIImage? {
    guard let baseName = ratingImageName else {
      return nil
    }
    return UIImage(named: "\(baseName)_small")
  }
  
  private var ratingImageName : String? {
    switch self {
    case .Unknown:
      return nil
    case .Rating(let value):
      return "pancake_rate_\(value)"
    }
  }
}



struct PancakeHouse {
  let name: String
  let photo: UIImage?
  let thumbnail: UIImage?
  let priceGuide: PriceGuide
  let location: CLLocationCoordinate2D?
  let details: String
  let rating: PancakeRating
}

extension PancakeHouse {
   init?(dict: [String : AnyObject]) {
    guard let name = dict["name"] as? String,
      let priceGuideRaw = dict["priceGuide"] as? Int,
      let priceGuide = PriceGuide(rawValue: priceGuideRaw),
      let details = dict["details"] as? String,
      let ratingRaw = dict["rating"] as? Int,
      let rating = PancakeRating(value: ratingRaw) else {
        return nil
    }

    self.name = name
    self.priceGuide = priceGuide
    self.details = details
    self.rating = rating
    
    if let imageName = dict["imageName"] as? String where !imageName.isEmpty {
      photo = UIImage(named: imageName)
    } else {
      photo = nil
    }
    
    if let thumbnailName = dict["thumbnailName"] as? String where !thumbnailName.isEmpty {
      thumbnail = UIImage(named: thumbnailName)
    } else {
      thumbnail = nil
    }
    
    if let latitude = dict["latitude"] as? Double,
      let longitude = dict["longitude"] as? Double {
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    } else {
      location = nil
    }
  }
}

extension PancakeHouse {
  static func loadDefaultPancakeHouses() -> [PancakeHouse]? {
    return self.loadPancakeHousesFromPlistNamed("pancake_houses")
  }
  
  static func loadPancakeHousesFromPlistNamed(plistName: String) -> [PancakeHouse]? {
    guard let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"),
      let array = NSArray(contentsOfFile: path) as? [[String : AnyObject]] else {
        return nil
    }
    
    return array.map { PancakeHouse(dict: $0) }
                .filter { $0 != nil }
                .map { $0! }
  }
}

extension PancakeHouse : CustomStringConvertible {
  var description : String {
    return "\(name) :: \(details)"
  }
}



