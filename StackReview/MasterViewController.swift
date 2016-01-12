import UIKit

class MasterViewController: UITableViewController {
  
  var pancakeHouses = [PancakeHouse]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let seedPancakeHouses = PancakeHouse.loadDefaultPancakeHouses() {
      pancakeHouses += seedPancakeHouses
      pancakeHouses = pancakeHouses.sort { $0.name < $1.name }
    }
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
  }
  
  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        if let controller = (segue.destinationViewController as! UINavigationController).topViewController as? PancakeHouseViewController {
          controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
          controller.navigationItem.leftItemsSupplementBackButton = true
          let pancakeHouse = pancakeHouses[indexPath.row]
          controller.pancakeHouse = pancakeHouse
        }
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pancakeHouses.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    let pancakeHouse = pancakeHouses[indexPath.row]
    if let cell = cell as? PancakeHouseTableViewCell {
      cell.pancakeHouse = pancakeHouse
    } else {
      cell.textLabel?.text = pancakeHouse.name
    }
    
    return cell
  }
}

