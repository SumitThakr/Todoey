//
//  ViewController.swift
//  Todoey
//
//  Created by abc on 9/25/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
   // var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
         
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    //Mark - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //cell.textLabel?.text=itemArray[indexPath.row]
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text=item.title
        
        //Ternary operator==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done==true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        if itemArray[indexPath.row].done==false{
        //            itemArray[indexPath.row].done=true
        //        }else{
        //            itemArray[indexPath.row].done=false
        //        }
       
        //or
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        

        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MArk - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            //print(textField.text!)
            let newItem = Item()
            newItem.title=textField.text!
            self.itemArray.append(newItem)
//            self.itemArray.append(textField.text!)
            
             self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
             self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    

}

