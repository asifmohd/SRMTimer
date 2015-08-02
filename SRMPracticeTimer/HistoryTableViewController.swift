//
//  HistoryTableViewController.swift
//  SRMPracticeTimer
//
//  Created by Mohd Asif on 23/08/14.
//  Copyright (c) 2014 Asif. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // CoreData constants and variables
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise the fetchedResultController to be used as a data source for the tableView
        self.fetchedResultController = self.getFetchedResultController()
        self.fetchedResultController.delegate = self
        self.fetchedResultController.performFetch(nil)

        // Enable editing of the tableView
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.fetchedResultController.sections![0].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimerDataCell", forIndexPath: indexPath) as! TimerDataTableViewCell
        let data = self.fetchedResultController.objectAtIndexPath(indexPath) as! TimerData
        
        // Configure the cell...
        cell.problemNameLabel.text = data.problemName
        cell.divisionLabel.text = data.division
        cell.languageLabel.text = data.language
        cell.timeTakenLabel.text = "Time: \(data.timerValue)"
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        cell.dateLabel.text = formatter.stringFromDate(data.dateEntered)

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source and save
            var objectToDelete = self.fetchedResultController.objectAtIndexPath(indexPath) as! TimerData
            self.managedObjectContext?.deleteObject(objectToDelete)
            self.managedObjectContext?.save(nil)
        }
    }
    
    // MARK: - CoreData Helpers
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: dataFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func dataFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TimerData")
        let sortDescriptor = NSSortDescriptor(key: "dateEntered", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.destinationViewController.isKindOfClass(DetailsViewController)) {
            var dvc = segue.destinationViewController as! DetailsViewController
            dvc.timerDataObject = self.fetchedResultController.objectAtIndexPath(self.tableView.indexPathForSelectedRow()!) as? TimerData
        }
    }
}
