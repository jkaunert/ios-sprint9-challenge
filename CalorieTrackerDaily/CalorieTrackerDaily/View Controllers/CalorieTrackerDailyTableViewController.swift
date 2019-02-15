//
//  CalorieTrackerDailyTableViewController.swift
//  CalorieTrackerDaily
//
//  Created by TuneUp Shop  on 2/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData

class CalorieTrackerDailyTableViewController: UITableViewController {
    let reuseIdentifier = "CalorieEntryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return calorieTrackerEntries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CalorieEntryTableViewCell
        // Configure the cell...
        let entry = calorieTrackerEntries[indexPath.row]
        let formatter = DateFormatter()
        let dateString = formatter.string(from: entry.date!)
        let caloriesString = String(entry.calories)
        print(dateString)
//        cell.caloriesLabel.text = entry.value(forKey: "calories") as? String
//        cell.timestampLabel.text = entry.value(forKey: "date") as? String
        cell.caloriesLabel.text = "Calories: \(caloriesString)"
        cell.timestampLabel.text = "T: \(dateString)"


        return cell
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Properties
    let moc = CoreDataStack.shared.mainContext
    //var calorieTrackerEntries: [NSManagedObject] = []
    var calorieTrackerEntries: [CalorieTrackerEntry] = []
    
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        let addEntryAlert = UIAlertController(title: "Add Calorie Intake", message: "Enter the amount of calories in the field below.", preferredStyle: .alert)
        addEntryAlert.addTextField { (calorieInputTextField) in
            calorieInputTextField.placeholder = "Enter Calories: "
        }
        addEntryAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
        addEntryAlert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {
            [unowned self] action in
            //TODO: - handle submit entry
            guard let textField = addEntryAlert.textFields?.first, let caloriesToSave = textField.text else { return }
            let newEntry = CalorieTrackerEntry(calories: Int32(caloriesToSave) ?? 0, context: self.moc)
            self.calorieTrackerEntries.append(newEntry)
            print(newEntry)
            print(self.calorieTrackerEntries)
            self.tableView.reloadData()
            
        }))
        
        self.present(addEntryAlert, animated: true)
    }
    
    
    @IBOutlet weak var calorieChart: Chart!
    
}