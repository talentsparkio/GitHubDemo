//
//  ViewController.swift
//  GitHubDemo
//
//  Created by Nick Chen on 7/28/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var hello: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        
        hello = UILabel(frame: CGRectMake(27.5, 100, 320, 30))
        if let hello = hello {
            hello.textAlignment = NSTextAlignment.Center
            hello.textColor = UIColor.blackColor()
            hello.font = UIFont(name: "System", size: 20)
            hello.text = "Hello, World!"
            view.addSubview(hello)
        }
        
        let world = UIImageView(frame: CGRectMake(59.5, 130, 256, 256))
        world.image = UIImage(named:"World")
        world.clipsToBounds = true
        view.addSubview(world)
        
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.frame = CGRectMake(27.5, 400, 320, 30)
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(18)
        button.setTitle("Click me", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        let textField = UITextField(frame: CGRectMake(27.5, 435, 320, 20))
        textField.placeholder = "Enter some text"
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.keyboardType = UIKeyboardType.Default
        textField.delegate = self
        view.addSubview(textField)
    }
    
    func buttonClicked() {
        hello?.text = "Hello, Clicker!"
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let hello = hello {
            hello.text = textField.text
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let hello = hello {
            hello.text = "Waiting for input...."
        }
    }

    // MARK: -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

