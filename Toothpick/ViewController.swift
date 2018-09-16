//
//  ViewController.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstBox: UITextField!
    @IBOutlet weak var secondBox: UITextField!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("RUNNING?")
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstBox.delegate = self
        secondBox.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? page2
        {
            vc.distance = Int(firstBox.text!)!
            vc.numPeople = Int(secondBox.text!)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

