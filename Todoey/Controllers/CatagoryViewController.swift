//
//  CatagoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Nirajan Chapagain on 4/24/20.
//  Copyright © 2020 Nirajan Chapagain. All rights reserved.
//

import UIKit
import CoreData

class CatagoryViewController: UITableViewController {
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    var defaults=UserDefaults.standard
    var catagoriesArray = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if (defaults.array(forKey:"TodoListArray") as? [String]) != nil{
//
        loadData()
      //  }
    }

    // MARK: - Table view data source

    
    @IBAction func clicked(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert = UIAlertController(title:"Add new Items title",message:"",preferredStyle:.alert)
        
        let action = UIAlertAction(title:"Add Item ",style: .default){
            (action) in
            
            let newItem = Categories(context:self.context)
            newItem.name=textField.text!
          //  newItem.done=false
            self.catagoriesArray.append(newItem)
            
            self.saveItem()
            
        }
        alert.addTextField {
            (alertTextField) in
            alertTextField.placeholder="Create new items"
            textField=alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated:true,completion:nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catagoriesArray.count
        
    }
    
override func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
     //   itemArray[indexPath.row].done
        performSegue(withIdentifier: "goToItems", sender: self)
        
    
    }
   
    override func prepare(for seague: UIStoryboardSegue , sender: Any?) {
        let destinationVC = seague.destination as! TodoListViewController
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVC.selectedCatagory = catagoriesArray[indexPath.row]
        }  
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CatagoriesCell",for: indexPath)
        let item=catagoriesArray[indexPath.row]
        cell.textLabel?.text=item.name
        return cell
    }

    func saveItem() {
        do{
            try context.save()
        }catch{
            
        }
        self.tableView.reloadData()
}
    
    func loadData(with request:NSFetchRequest<Categories>=Categories.fetchRequest()){
        do{
            try catagoriesArray=context.fetch(request)
            
        }catch{
            print("error loading data \(error)")
        }
        tableView.reloadData()
    }
    
}
extension CatagoryViewController:UISearchBarDelegate{
     func searchBarSearchButtonClicked(_ searchBar:UISearchBar) {
         let request:NSFetchRequest<Categories>=Categories.fetchRequest()
         request.predicate=NSPredicate(format: "name contains[cd] %@",searchBar.text!)
         request.sortDescriptors = [NSSortDescriptor(key :"name",ascending: true)]
         loadData(with:request)
        
        func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String){
            if(searchText.count==0){
                loadData()
                DispatchQueue.main.async{
                    searchBar.resignFirstResponder()
                }
            }
        }
     }
 }
