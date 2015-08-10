//
//  AddTableViewController.swift
//  Daily-Objective
//
//  Created by Dan on 27.07.15.
//  Copyright (c) 2015 9volt. All rights reserved.
//

import UIKit
import CoreData



class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var quantityTextField:UITextField!
    @IBOutlet weak var schedule: UITextField!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var type: UISegmentedControl!
    
    
    var objective:Objective!
    var pickerVisible = false
    var selectedType = -1
    
    /// A date formatter to format the `date` property of `datePicker`.
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter
        }()
    
    func datePickerDateChanged(datePicker: UIDatePicker){
        println("Selected date = \(dateFormatter.stringFromDate(datePicker.date))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.addTarget(self, action: "datePickerDateChanged:", forControlEvents: .ValueChanged)
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                enum UIImagePickerControllerSourceType : Int {
                    case PhotoLibrary
                    case Camera
                }
                
                //imagePicker.sourceType = .PhotoLibrary
                //imagePicker.sourceType = .Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        if indexPath.row == 6 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
        
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    
    @IBAction func save() {
        
        // Form validation
        var errorField = ""
        
        if nameTextField.text == "" {
            errorField = "name"}
//        } else if typeTextField.text == "" {
//            errorField = "type"
//        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the " + errorField + " of objective. All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            
            objective = NSEntityDescription.insertNewObjectForEntityForName("Objective", inManagedObjectContext: managedObjectContext) as! Objective
            objective.name = nameTextField.text
            objective.quantity = quantityTextField.text
            objective.image = UIImagePNGRepresentation(imageView.image)
            objective.reminder = dateFormatter.stringFromDate(datePicker.date)
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e!.localizedDescription)")
                return
            }
        }
        
        
        // If all fields are correctly filled in, extract the field value
          println("Name: " + nameTextField.text)
          println("Quantity: " + quantityTextField.text)
          println(dateFormatter.stringFromDate(datePicker.date))
        
        
        // Execute the unwind segue and go back to the home screen
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }

    @IBAction func changeType(sender: UISegmentedControl) {
        var cell3Index = NSIndexPath.init(forRow: 3, inSection: 0)
        var quantityCell = self.tableView.cellForRowAtIndexPath(cell3Index)
        
        if sender.selectedSegmentIndex == 1 {
            quantityCell?.hidden = true
        }   else    {
            quantityCell?.hidden = false
        }
        
        // When updated with animation - cell border haswrong position
        self.tableView.reloadRowsAtIndexPaths([cell3Index], withRowAnimation: UITableViewRowAnimation.Fade)
        
        self.tableView.reloadData()
    }
    
    
    
    @IBAction func toggleValueChnaged(sender: UISwitch) {
        tableView.reloadData()
    }
    
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        date.text = dateFormatter.stringFromDate(sender.date)
    }
    

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            println(indexPath.row)
            println(type.selectedSegmentIndex)
        
        if indexPath.row == 0 {
            return 150.0
        }
        
        if type.selectedSegmentIndex == 1 && indexPath.row == 3 {
            return 0.0
        }
        
        if indexPath.row >= 1 && indexPath.row < 5 {
            return 72.0
        }
        
        if indexPath.row == 5 {
            return 52.0
        }
        
        if indexPath.row == 6 && toggle.on == false {
            return 0.0
        }
        if indexPath.row == 7 {
            if toggle.on == false || pickerVisible == false {
                return 0.0
            }
            return 165.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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

}
