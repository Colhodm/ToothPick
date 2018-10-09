//
//  endpage.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit
import GooglePlaces

class endpage: UIViewController {
    var done = false
    @IBAction func indicator(_ sender: Any) {
        done = true
    }
    @IBOutlet weak var restChoice: UILabel!
    @IBOutlet weak var googleMaps: UIButton!
    var distance: Int!
    var numPeople: Int!
    var myPlacesSoFar = [GooglePlaces.GMSPlace]()
    var selectedPlace = 0

 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let number = arc4random_uniform(2)
        print(number)
        switch number {
            case 0:
            restChoice.text = myPlacesSoFar[0].name
            selectedPlace = 0
            case 1:
            restChoice.text = myPlacesSoFar[1].name
            selectedPlace = 1
            case 2:
            restChoice.text = myPlacesSoFar[2].name
            selectedPlace = 2
            case 3:
            restChoice.text = myPlacesSoFar[3].name
            selectedPlace = 3
            case 4:
            restChoice.text = myPlacesSoFar[4].name
            selectedPlace = 4
            case 5:
            restChoice.text = myPlacesSoFar[5].name
            selectedPlace = 5
        default:
            print("stuff")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? MapViewController
        {
            vc.selectedPlace = myPlacesSoFar[selectedPlace]
            
        }
    }
 
    @IBAction func GoogleMapsActivation(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
