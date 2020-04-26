//
//  ViewController.swift
//  Todoe

//  Created by Nirajan Chapagain on 4/20/20.
//  Copyright © 2020 Nirajan Chapagain. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController:UITableViewController{
    
    var itemArray = [Item]()
    var defaults=UserDefaults.standard
    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        .first?.appendingPathComponent("Items.plist")
    let context=(UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    var selectedCatagory:Categories?{
        didSet{
            loadData()
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print(dataFilePath!)
      //  if (defaults.array(forKey: "TodoListArray") as? [String]) != nil{
            
            //            let newItem = Item()
            //            newItem.title="benji medicine"
            //            itemArray.append(newItem)
            //
            //
            //            let newItem2 = Item()
            //            newItem2.title="benji medicine"
            //            itemArray.append(newItem2)
            //
            //            let newItem3 = Item()
            //            newItem3.title="benji medicine"
            //            itemArray.append(newItem3)
            //
            //            let newItem4 = Item()
            //            newItem4.title="benji medicine"
            //            itemArray.append(newItem4)
            //            let newItem5 = Item()
            //            newItem5.title="benji medicine"
            //            itemArray.append(newItem5)
           
            
       // }
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
        //    itemArray[indexPath.row].setValue("new task", forKey: "title")
        //   itemArray.remove(at: indexPath.row)
        // context.delete(itemArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add New Todoey Item",message: "", preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add Item", style: .default)
        { (action) in
            
            
            
            let newItem=Item(context: self.context)
            newItem.title=textField.text!
            newItem.done=false
            newItem.parentCategory=self.selectedCatagory
            self.itemArray.append(newItem)
            
            self.saveItems()
            // self.defaults.set(self.itemArray,forKey: "TodoListArray")
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Createmnew items"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error encoding")
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request:NSFetchRequest<Item>=Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCatagory!.name!)
        
        if let additionalPredicate = predicate{
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        request.predicate=compoundPredicate
        request.predicate=predicate
        }else{
            request.predicate=categoryPredicate
        }
        //let request: NSFetchRequest<Item>=Item.fetchRequest()
        do{
                   itemArray = try context.fetch(request)
               }catch{
                   print("error loading data \(error)")
               }
               tableView.reloadData()
        //        if let data=try? Data(contentsOf: dataFilePath!){
        //            let decoder = PropertyListDecoder()
        //            do{
        //                itemArray =  try decoder.decode([Item].self, from: data)
        //            }catch{
        //                print("decode error")
        //            }
        //        }
    }
    
}

//MARK: Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item>=Item.fetchRequest()
        print(searchBar.text!)
        
       let predicate=NSPredicate(format: "title contains[cd] %@", searchBar.text!)
        
         request.sortDescriptors = [NSSortDescriptor(key: "title",ascending: true)]
        
  
        loadData(with:request,predicate: predicate)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count==0){
            loadData()
            DispatchQueue.main.async {
                 searchBar.resignFirstResponder()
                       
            }
           }
        
    }
}


