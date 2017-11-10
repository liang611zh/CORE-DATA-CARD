//
//  CategoryTableViewController.swift
//  CoreDataCard
//
//  Created by LIANG ZHAO on 2017-11-09.
//  Copyright © 2017 bcit. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var context : NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Category>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //create a request
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "categoryName",
            ascending: true
            )]
        
        //set up the fetchedResultsController
        fetchedResultsController = NSFetchedResultsController<Category>(
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



}
// related to NSFetchedResultsControllerDelegate
extension CategoryTableViewController {
    
    
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
extension CategoryTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CategoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of CategoryTableViewCell.")
        }
        let category = fetchedResultsController.object(at: indexPath)
        //get the category name
        cell.label.text = category.categoryName!
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implemdentation, return the number of sections
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
    //customize the swipe for tableview cell
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            //self.isEditing = false

            print("edit button tapped")
        }

        edit.backgroundColor = UIColor.blue
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            let currentcell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            Category.Delete(CategoryName: currentcell.label.text!,context: context)
            tableView.reloadData()
            print("delete button tapped")
        }
        delete.backgroundColor = UIColor.red

        
        return [ edit, delete]
    }
    
    
}


