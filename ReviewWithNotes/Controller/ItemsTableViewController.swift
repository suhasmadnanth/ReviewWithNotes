//
//  ItemsTableViewController.swift
//  ReviewWithNotes
//
//  Created by Suhas on 11/04/20.
//  Copyright © 2020 suhasmadnanth. All rights reserved.
//

import UIKit
import CoreData

class ItemsTableViewController: UITableViewController {
    
    var itemsArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedSection : Section? {
        didSet{
            loadItems()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        let predicate = NSPredicate(format: "toParentSection.sectionName MATCHES %@", selectedSection!.sectionName!)
        request.predicate = predicate
        do{
            itemsArray = try context.fetch(request)
        }catch{
            print("Error fetching Items \(error)")
        }
        self.tableView.reloadData()
    }
    
    func saveItems() {
        do{
            try context.save()
        }catch{
            print("Error saving Item \(error)")
        }
        self.tableView.reloadData()
    }
    
    // - MARK TableView Delegate and DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemsTableViewCell
        cell.configureCell(itemToBeConfigured: item)
        cell.itemsImageView.layer.cornerRadius = cell.itemsImageView.frame.height / 2
        cell.layer.cornerRadius = 50
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toReviewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destivationVC = segue.destination as! ReviewViewController
        let indexPath = tableView.indexPathForSelectedRow
        let item = itemsArray[indexPath!.row]
        destivationVC.selectedItem = item
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(itemsArray[indexPath.row])
            itemsArray.remove(at: indexPath.row)
            saveItems()
        }
    }
    
    
    @IBAction func addItemsButtonTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.itemName = textField.text
            newItem.itemNotes = nil
            newItem.itemPoints = 0
            newItem.toParentSection = self.selectedSection
            self.itemsArray.append(newItem)
            self.saveItems()
        }
        
        alert.addTextField { (addItemsTextField) in
            addItemsTextField.placeholder = "Add new Item"
            textField = addItemsTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}
