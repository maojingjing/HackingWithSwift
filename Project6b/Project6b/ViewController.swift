//
//  ViewController.swift
//  Project6b
//
//  Created by Jingjing Mao on 1/11/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .cyan
        label1.text = "ARE"
        label1.sizeToFit()
        
        let label3 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .yellow
        label1.text = "SOME"
        label1.sizeToFit()
        
        let label4 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .green
        label1.text = "AWESOME"
        label1.sizeToFit()
        
        let label5 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .orange
        label1.text = "LABELS"
        label1.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        for label in viewDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
        }

        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewDictionary))
    }

}

