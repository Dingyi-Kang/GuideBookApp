//
//  ViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //get the places from core data
        places = try! context.fetch(Place.fetchRequest())
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //doubel check the a row was selected
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        //get the selected object
        let place = places[tableView.indexPathForSelectedRow!.row]
        //get a reference to the detailPlace VC
        let placeVC = segue.destination as! PlaceViewController
        //pass object the into that VC
        placeVC.place = place
        
        
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //get a cell reference
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceTableViewCell
        
        //customize the cell for displaying
        cell.setCell(self.places[indexPath.row])
        
        return cell
    }
    
    
    
    
}
