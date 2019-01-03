//
//  ToDoListViewController.swift
//  Todoey
//
//  Created by Monk Wellington on 1/2/19.
//  Copyright © 2019 Industrial Logic. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var items: [Item] = []
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        var newItem = Item()
        newItem.title = "Find Mike"
        items.append(newItem)
        var secondItem = Item()
        secondItem.title = "Buy Eggos"
        items.append(secondItem)
        var thirdItem = Item()
        thirdItem.title = "Destroy Demogorgon"
        items.append(thirdItem)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            self.items = items
        }
    }

    // MARK - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }

    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        items[indexPath.row].done = !items[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField = UITextField()
        let alert: UIAlertController = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { action in
            var newItem = Item()
            newItem.title = textField.text ?? ""
            self.items.append(newItem)
            self.defaults.set(self.items, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

