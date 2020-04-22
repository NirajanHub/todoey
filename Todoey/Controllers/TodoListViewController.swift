//
//  ViewController.swift
//  Todoe

//  Created by Nirajan Chapagain on 4/20/20.
//  Copyright © 2020 Nirajan Chapagain. All rights reserved.
//

import UIKit

class TodoListViewController:UITableViewController{
    var itemArray = [Item]()
    var defaults=UserDefaults.standard
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            
            let newItem = Item()
            newItem.title="benji medicine"
            itemArray.append(newItem)
            
            
            let newItem2 = Item()
            newItem2.title="benji medicine"
            itemArray.append(newItem2)
            
            let newItem3 = Item()
            newItem3.title="benji medicine"
            itemArray.append(newItem3)
            
            let newItem4 = Item()
            newItem4.title="benji medicine"
            itemArray.append(newItem4)
            let newItem5 = Item()
            newItem5.title="benji medicine"
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            itemArray.append(newItem5)
            
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    //MARK - TableView Datasourse Model
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
     
        let item=itemArray[indexPath.row]
             
        cell.textLabel?.text=item.title
        
       
        if item.done==true {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    //Mark Tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New Todoey Item",
                                    message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default)
        { (action) in
            
            let newItem=Item()
            newItem.title=textField.text!
            self.itemArray.append(newItem)
            
            self.tableView.reloadData()
            self.defaults.set(self.itemArray,forKey: "TodoListArray")
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Createmnew items"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}


