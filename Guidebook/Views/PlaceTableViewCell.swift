//
//  PlaceTableViewCell.swift
//  Guidebook
//
//  Created by OSU App Center on 6/27/21.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    //MARK: property
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    //MARK: life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //style the cell background
        cardView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ p: Place) {
        
        if p.imageName != nil {
        self.placeImageView.image = UIImage(named: p.imageName!)
        }
        self.label.text = p.name
        
    }
    
}
