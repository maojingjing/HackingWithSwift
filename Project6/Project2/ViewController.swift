//
//  ViewController.swift
//  Project2
//
//  Created by Jingjing Mao on 1/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        
        askQuestions()
    }
    
    func askQuestions(action: UIAlertAction!=nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + ": total score is " + String(score)
        questionAsked += 1

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var buttonTitle: String
        var errorMessage: String
        
        if sender.tag == correctAnswer {
            buttonTitle = "Correct"
            score += 1
            errorMessage = ""
        } else {
            buttonTitle = "Wrong"
            errorMessage = "The wrong one you picked is " + countries[sender.tag].uppercased()
            score -= 1
        }
        
        if (questionAsked>=10) {
            return
        }
        
        let ac = UIAlertController(title: buttonTitle, message: "Your score is \(score) " + errorMessage, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
        
        present(ac, animated: true)
    }
    
    
    
}

