//
//  endpage.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit

class endpage: UIViewController {
    var done = false
    @IBAction func indicator(_ sender: Any) {
        done = true
    }
    @IBOutlet weak var restChoice: UILabel!
    @IBOutlet weak var googleMaps: UIButton!
    var personOne : String!
    var distance: Int!
    var numPeople: Int!
    var personTwo : String!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("GOT HERE")
        print(personTwo)
        print(personOne)
        let number = arc4random_uniform(2)
        print(number)
        switch number {
            case 0:
            restChoice.text = personOne
            case 1:
            restChoice.text = personTwo
            case 2:
            print("stuff")
            case 3:
            print("another")
        default:
            print("stuff")
        }
    }
 
    @IBAction func GoogleMapsActivation(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
