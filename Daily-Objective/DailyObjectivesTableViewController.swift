//
//  DailyObjectivesTableViewController.swift
//  Daily-Objective
//
//  Created by Dan on 15.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import UIKit
import CoreData

class DailyObjectivesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchResultController:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetching Data Using Core Data
        var fetchRequest = NSFetchRequest(entityName: "Objective")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            var e: NSError?
            var result = fetchResultController.performFetch(&e)
            objectives = fetchResultController.fetchedObjects as! [Objective]
            
            if result != true {
                println(e?.localizedDescription)
            }
        }
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action:nil)
        
//         //Self sizing cells:
//        self.tableView.estimatedRowHeight = 80.0;
//        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hides the navigation bar on swipe
        self.navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
   // override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    /*
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */


    var objectives:[Objective] = []
//        Objective(name: "Train Eyesight", icon: "eyesight", progress: 1, status: false),
//        Objective(name: "Pushups", icon: "pushups", progress: 8, status: false),
//        Objective(name: "Buy Milk", icon: "milk", progress: 0, status: false),
//        Objective(name: "Solve 1 Challenge", icon: "challenge", progress: 0, status: false),
//        Objective(name: "Make 10k Steps", icon: "walking", progress: 3, status: false),
//        Objective(name: "Eat 100 proteins", icon: "proteins", progress: 7, status: false)
//    ]
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return self.objectives.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        let objective = objectives[indexPath.row]
        cell.nameLabel.text = objective.name
        cell.thumbnailImageView.image = UIImage(data: objective.image)
        cell.reminderLabel.text = "Remind: \(objective.reminder)"
        //cell.progressBar.progress = progress
        
        
        // Circular icon
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        // Checkmark
        cell.accessoryType = objective.status.boolValue ? .Checkmark : .None
        return cell
        }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        // Create an option menu as an action sheet
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .ActionSheet)
//        
//        // Add actions to the menu
//        // Cancel Action
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
        
//            // Add call action
//        // closure
//        let callActionHandler = { (action:UIAlertAction!) -> Void in
//            
//            let alertMessage = UIAlertController(title: "Service Unavailable", message: "How do you think you will call your objective?", preferredStyle: .Alert)
//            alertMessage.addAction(UIAlertAction(title: "I'm drunk", style: .Default, handler: nil))
//            self.presentViewController(alertMessage, animated: true, completion: nil)}
//        
//        
//        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: UIAlertActionStyle.Default, handler: callActionHandler)
//        optionMenu.addAction(callAction)
//        
//            // Add "Completed" action
//            // inline closure
//        let isCompletedTitle = objective.status[indexPath.row] ? "I lied" : "I did this!"
//        let isCompletedAction = UIAlertAction(title: isCompletedTitle, style: .Default, handler: {
//            (action:UIAlertAction!) -> Void in
//            
//            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
//            
//            //Toggle Checkmark
//            self.completedObjectives[indexPath.row] = self.completedObjectives[indexPath.row] ? false : true
//            cell.accessoryType = self.completedObjectives[indexPath.row] ? .Checkmark : .None
//            
//            })
//        optionMenu.addAction(isCompletedAction)
        
        // Deselect cell
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        
        // Display the menu
       // self.presentViewController(optionMenu, animated: true, completion: nil)
    }
  
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from data source
            self.objectives.removeAtIndex(indexPath.row)
          
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            println("Total item: \(self.objectives.count)")
            for objective in objectives {
                println(objective)
                }
            
            }
        }
    
   override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject] {
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
    
    var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
        
        // Delete the row from the data source
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            let objectiveToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Objective
            managedObjectContext.deleteObject(objectiveToDelete)
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("delete error: \(e!.localizedDescription)")
                }
            }
        })
    
    shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    return [deleteAction, shareAction]
        }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showObjectiveDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.objective = objectives[indexPath.row]
            }
        }
    }
    
    
    // Refreshing table with new entries
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            tableView.reloadData()
        }
        
        objectives = controller.fetchedObjects as! [Objective]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
}

    
    

