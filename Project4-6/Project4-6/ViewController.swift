//
//  ViewController.swift
//  Project4-6
//
//  Created by Jingjing Mao on 1/14/24.
//

import UIKit

class ViewController: UITableViewController {
    var allShoppingItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(clearShoppingList))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allShoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath)
        cell.textLabel?.text = allShoppingItems[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter new item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func clearShoppingList() {
        allShoppingItems.removeAll()
        tableView.reloadData()
    }
    
    @objc func sharedTapped() {
        let sharedList = allShoppingItems.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [sharedList as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func submit(_ answer: String) {
        allShoppingItems.insert(answer, at: 0)
        let indexPath = IndexPath(row:0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
}

