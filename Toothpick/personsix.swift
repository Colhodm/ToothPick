//
//  personthree.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/20/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class personsix: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personSixText: UITextField!
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    var personTwo :String!
    var personThree :String!
    var personFour :String!
    var personFive :String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personSixText.delegate = self


        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapTo(_ sender: Any) {
        if numPeople! > 6  {
            print("Too many people")
            /*Use the Identifier you given in story Board*/
            //  self.performSegue(withIdentifier: "personsixtopersonsix", sender: self)
            
        } else {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personsixtoendscreen", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? landingpage
        {
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwo
            vc.personThree = personThree
            vc.personFour = personFour
	    vc.personFive = personFive
	    vc.personSix = personSixText.text!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
