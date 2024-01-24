//
//  ViewController.swift
//  Project7-9
//
//  Created by Jingjing Mao on 1/23/24.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var guessedWords = [String]()
    var pickedWordCharArray = Array("")
    var result = Array("")
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        let pickedWordString: String = allWords.randomElement()!
        pickedWordCharArray = Array(pickedWordString)
        print(pickedWordString)
        let characterToAppend: Character = "?"
        let repeatedString = String(repeating: characterToAppend, count: pickedWordCharArray.count)
        result = Array(repeatedString)
        title = repeatedString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return guessedWords.count
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
           cell.textLabel?.text = guessedWords[indexPath.row]
           return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        if answer.count != 1 {
            showErrorMessage(title: "Word length is not right",  errorMessage: "Please only enter one character")
            return;
        }
        
        let singleAnswer = Array(answer)[0]
        
        var didFindOne = false
        if !result.contains(singleAnswer) {
            for (index, character) in pickedWordCharArray.enumerated() {
                if (character == singleAnswer) {
                    result[index] = singleAnswer
                    score += 1
                    showResultMessage(title: "You win", result: "total score is \(score)")
                    didFindOne = true
                }
            }
        }
        
        if !didFindOne {
            score -= 1
            showResultMessage(title: "You lose", result: "total score is \(score)")
        }
        
        title = String(result)
    }
    
    func showErrorMessage(title: String, errorMessage: String) {
        let ac = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showResultMessage(title: String, result: String) {
        let ac = UIAlertController(title: title, message: result, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
       


}

