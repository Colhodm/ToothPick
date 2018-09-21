//
//  personthree.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/20/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class personthree: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personThreeText: UITextField!
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    var personTwo :String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personThreeText.delegate = self


        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapToContinue(_ sender: Any) {
        print("XLOOOOOX")
        print(numPeople)
        if numPeople! > 3  {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personthreetopersonfour", sender: self)
            
        } else {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personthreetoendscreen", sender: self)
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
            vc.personThree = personThreeText.text!
        } else if let vc = segue.destination as? personfour{
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwo
            vc.personThree = personThreeText.text!
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
