//
//  CategoriesTableViewController.swift
//  ReviewWithNotes
//
//  Created by Suhas on 11/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class CategoriesTableViewController: UITableViewController {
    
    var sectionItemsArray = [Section]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()

    }

    func loadItems() {
        let request : NSFetchRequest<Section> = Section.fetchRequest()
        do{
            sectionItemsArray = try context.fetch(request)
        }catch{
            print("error fetching request \(error)")
        }
        
    }

    func saveItems() {
        do{
            try context.save()
        }catch{
            print("Error saving Sections \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func addSectionsButtonTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Alert", message: "This is a message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Section", style: .default) { (action) in
            let newSection = Section(context: self.context)
            newSection.sectionName = textField.text
            self.sectionItemsArray.append(newSection)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new Section"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = sectionItemsArray[indexPath.row].sectionName
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItemsListSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destivationViewController = segue.destination as! ItemsTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destivationViewController.selectedSection = sectionItemsArray[indexPath.row]
        }
    }
    
}

extension CategoriesTableViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "delete") { action, indexPath in
            self.context.delete(self.sectionItemsArray[indexPath.row])
            self.sectionItemsArray.remove(at: indexPath.row)
            self.saveItems()
        }
        
        return [deleteAction]
    }
}
