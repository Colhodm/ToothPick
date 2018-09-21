//
//  page3.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class page3: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var personTwos: UITextField!
    
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    @IBAction func TapButton(_ sender: UIButton) {
        print("HELLO")
        print(numPeople)
        if numPeople! > 2  {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "persontwotopersonthree", sender: self)
            
        } else {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "persontwotoendscreen", sender: self)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personTwos.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? landingpage
        {
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwos.text!
        } else if let vc = segue.destination as? personthree{
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwos.text!
        }
        print("finishes my segue")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

