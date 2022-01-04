//
//  InfoViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit

class InfoViewController: UIViewController {

    
    @IBOutlet weak var summaryLabel: UILabel!
    
    var place:Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = place?.summary
    }

}
