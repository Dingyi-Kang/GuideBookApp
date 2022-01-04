//
//  AddNoteViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/28/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var place:Place?
    
    var note:Note?
    
    
    var delegate:addNoteDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    //given we cannot set the backgorund color and corner of the stackView, we need a UIView as the background of the stackView
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        cardView.layer.opacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
        // Do any additional setup after loading the view.
        
        if note != nil {
            textView.text = note!.text
        }
        
    }
    

    @IBAction func cancelNoteTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func saveNoteTapped(_ sender: Any) {
        //create a new note
        if note == nil {
            let n = Note(context: context)
        //configure the properties
            n.date = Date()
            n.place = self.place
            n.text = textView.text}
        else{
            note!.text = textView.text
            note!.date = Date()
        }
        //save the core data context
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //notify the noteVC to redownload and reload the table view
        delegate?.refresh()
        self.dismiss(animated: true, completion: nil)
    }
    
}


protocol addNoteDelegate {
   func refresh()
}
