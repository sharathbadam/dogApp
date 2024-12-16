//
//  ListVC.swift
//  dogApp
//
//  Coding Exercise:
//  When a table item is selected, pass the item to DogVC
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let items = ["Chihuahua", "Husky", "Labrador"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let cellNib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ListCell")
        
    }
    
    // Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    // Configures and returns the cell for a specific row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListCell else {
            return UITableViewCell()
        }
        
        cell.configureFor(text: items[indexPath.row])
        return cell
    }
    
    // Handles the row selection and navigates to the DogVC to display details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dogVC = DogVC()
        dogVC.configurFor(dogBreed: items[indexPath.row])
        self.show(dogVC, sender: self)
    }
}
