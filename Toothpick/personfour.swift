//
//  personthree.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/20/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class personfour: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personFourText: UITextField!
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    var personTwo :String!
    var personThree :String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personFourText.delegate = self


        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func toTap(_ sender: Any) {
    if numPeople! > 4  {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personfourtopersonfive", sender: self)
            
        } else {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personfourtoendscreen", sender: self)
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
            vc.personFour = personFourText.text!
        } else if let vc = segue.destination as? personfive{
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwo
            vc.personThree = personThree
            vc.personFour = personFourText.text!
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
