//
//  CardTableViewController.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-10.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData
class CardTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{
    var context : NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Card>!
    //var for passing to show controller
    var cardbackinfo:String=""
    var cardfrontinfo:String=""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //create a request
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "keyword",
            ascending: true
            )]
        
        //set up the fetchedResultsController
        fetchedResultsController = NSFetchedResultsController<Card>(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        //set delegate
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        let card = fetchedResultsController.object(at: indexPath as IndexPath)
        cardfrontinfo = card.cardfront!
        cardbackinfo = card.cardback!
        print(cardfrontinfo)
        self.performSegue(withIdentifier: "showSegue", sender: self)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showSegue" {
            if let viewControllerB = segue.destination as? ShowCardViewController {
                viewControllerB.fronttext = cardfrontinfo
                viewControllerB.backtext = cardbackinfo
            }
        }
    }
}
// related to NSFetchedResultsControllerDelegate
extension CardTableViewController {
    
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections([sectionIndex], with: .fade)
        case .delete: tableView.deleteSections([sectionIndex], with: .fade)
        default: break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

//table view stuff
extension CardTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardTableViewCell else {
            fatalError("The dequeued cell is not an instance of CardTableViewCell.")
        }
        let card = fetchedResultsController.object(at: indexPath)
        //get the card name
        cell.cardlable.text = card.keyword!
        return cell
    }
    
    
    //customize the swipe for tableview cell
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            //self.isEditing = false
            
            print("edit button tapped")
        }
        
        edit.backgroundColor = UIColor.blue
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let currentcell = tableView.cellForRow(at: indexPath) as! CardTableViewCell
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            Card.Delete(KeyWord: currentcell.cardlable.text! ,context: context)
            tableView.reloadData()
            print("delete button tapped")
        }
        delete.backgroundColor = UIColor.red
        
        
        return [ edit, delete]
}
}
