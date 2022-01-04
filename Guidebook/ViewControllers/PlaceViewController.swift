//
//  PlaceViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit

class PlaceViewController: UIViewController {

    lazy var infoVC:InfoViewController={
        let infoVC = storyboard?.instantiateViewController(identifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        return infoVC
    }()
    
    lazy var mapVC:MapViewController = {
        let mapVC = storyboard?.instantiateViewController(identifier: Constants.MAP_VIEWCONTROLLER) as! MapViewController
        return mapVC
    }()
    
    lazy var noteVC:NotesViewController = {
        let noteVC = storyboard?.instantiateViewController(identifier: Constants.NOTES_VIEWCONTROLLER) as! NotesViewController
        return noteVC
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    var place:Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set the image
        if place?.imageName != nil{
            imageView.image = UIImage(named: place!.imageName!)
        }
        
        //set the name
        label.text = place?.name
        
        //place an instance of infoVC
        //let infoVC = storyboard?.instantiateViewController(identifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        segmentTap(self.segmentControl)
    }

    private func switchChildView(_ childVC:UIViewController){
        //set it as the child as this VC
        addChild(childVC)
        //add its view into the container
        containerView.addSubview(childVC.view)
        //set its frame and size
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //indicate that it is now a child view controller
        childVC.didMove(toParent: self)
    }
    
    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            infoVC.place = self.place
            switchChildView(infoVC)
        case 1:
            mapVC.place = self.place
            switchChildView(mapVC)
        case 2:
            noteVC.place = self.place
            switchChildView(noteVC)
        default:
            infoVC.place = self.place
            switchChildView(infoVC)
        }
        
    }
    
    
}
