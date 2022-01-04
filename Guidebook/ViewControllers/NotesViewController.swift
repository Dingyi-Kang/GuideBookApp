//
//  NotesViewController.swift
//  Guidebook
//
//  Created by OSU App Center on 6/26/21.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    var place:Place?
    
    var fetchedNoteFC:NSFetchedResultsController<Note>?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //check if there is a place set within this VC
        if let place = self.place {
            
            //get a fetch request for the places
            let request = Note.fetchRequest() as NSFetchRequest<Note>
            
            //set the filter: only for this place object
            request.predicate = NSPredicate(format: "place = %@",place)
            
            //set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            //create a fetched results controller// the result will be stored inside this FC after perfoming fetching
            self.fetchedNoteFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            //execute fetch
            try! fetchedNoteFC!.performFetch()
            self.tableView.reloadData()
        }
    }
    

    @IBAction func addNoteTapped(_ sender: Any) {
        
            //display the pop up
            let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADD_NOTES_VC) as! AddNoteViewController
            //pass the place object into the note object which is in the addNoteVC,
            addNoteVC.place = self.place
            //set self as delegate for get feedback from addNoteVC
            addNoteVC.delegate = self
            //configure the popup mode
            addNoteVC.modalPresentationStyle = .overCurrentContext
            //present it
            present(addNoteVC, animated: true, completion: nil)
            
    }
    
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedNoteFC?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let dateLable = cell.viewWithTag(1) as! UILabel
        let noteLabel = cell.viewWithTag(2) as! UILabel
        
        let note = fetchedNoteFC?.object(at: indexPath)
        
        if let note = note {
            let df = DateFormatter()
            
            df.dateFormat = "MMM d - h:mm a"
            
            dateLable.text = df.string(from: note.date!)
        
            noteLabel.text = note.text
        }
        return cell
    }
    
    //another table view delegate mthod
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deletionAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, nil) in
            
            if self.fetchedNoteFC == nil {
                return
            }
            
            //get a reference to the note to be deleted
            let n = self.fetchedNoteFC?.object(at: indexPath)
            
            //pass it to the core data delete method
            self.context.delete(n!)
            //save the context
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            //refetch the result and refresh the table view
            self.refresh()
        }
        
        return UISwipeActionsConfiguration(actions: [deletionAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADD_NOTES_VC) as! AddNoteViewController
        
        if self.fetchedNoteFC == nil {
            return
        }
        
        let n = self.fetchedNoteFC!.object(at: indexPath)
        addNoteVC.note = n
        //you have to specify the relationship property of entity if you wanna save it in the context of core data later
        addNoteVC.place = self.place
        addNoteVC.delegate = self
        addNoteVC.modalPresentationStyle = .overFullScreen
        present(addNoteVC, animated: true, completion: nil)
        
    }
    
}


extension NotesViewController: addNoteDelegate{
    func refresh() {
        
        if let place = place {
            
            let request = Note.fetchRequest() as NSFetchRequest<Note>
            
            request.predicate = NSPredicate(format: "place = %@", place)
            
            let sort = NSSortDescriptor(key: "date", ascending: false)
            
            request.sortDescriptors = [sort]
            
            self.fetchedNoteFC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            try! self.fetchedNoteFC?.performFetch()
            
            self.tableView.reloadData()
        }
        
    }
}
