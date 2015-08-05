//
//  ViewController.swift
//  GitHubDemo
//
//  Created by Nick Chen on 7/28/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hello: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        hello.text = "Hello, Clicker!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

