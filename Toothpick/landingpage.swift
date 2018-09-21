//
//  landingpage.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class landingpage: UIViewController {
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    var personTwo : String!
    var personThree : String!
    var personFour : String!
    var personFive : String!
    var personSix : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? endpage
        {
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne
            vc.personTwo = personTwo
            vc.personThree = personThree
            vc.personFour = personFour
            vc.personFive = personFive
            vc.personSix = personSix
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
