//
//  page2.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit
import GooglePlaces

class page2: UIViewController, UITextFieldDelegate {
    var distance = 0
    var numPeople = 0
    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    var myArray = [String]()


    @IBOutlet weak var myOptions: UITableView!
    

    
    @IBOutlet weak var personOne: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personOne.delegate = self
        self.locationManager.delegate = self
        self.placesClient = GMSPlacesClient.shared()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.myOptions.delegate = self
        self.myOptions.dataSource = self
        self.myOptions.isScrollEnabled = true;
        self.myOptions.isHidden = true;
        personOne.addTarget(self, action: #selector(searchRecords(textField:)), for: .editingChanged)

        // Do any additional setup after loading the view, typically from a nib.
    }
  
    
    @objc func searchRecords(textField:UITextField){
        if personOne.text!.count >= 4{
        placeAutocomplete()
        self.myOptions.reloadData()
        myOptions.isHidden = false;
        } else {
            myOptions.isHidden = true;
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? page3
        {
            vc.distance = distance
            vc.numPeople = numPeople
            vc.personOne = personOne.text!
            print(distance)
            print(numPeople)
        }
    }
    
    @IBAction func finishedTyping(_ sender: Any) {
        print("FINISHED TYPING THIS SHOULD BE RUNNING")
        print("FINISHED TYPING THIS SHOULD REALLY BE RUNNING")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func placeAutocomplete() {
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery(personOne.text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                // SHOULD FIX THIS SO IT MAKES LESS CALLS TO GOOGLE API SINCE WE"RE THROTTLED
                self.myArray = [String]()
                for result in results {
                    self.myArray.append(result.attributedPrimaryText.string)
                }
            }
        })
    }
}

extension page2: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let temp = "myArray"
        var cell = tableView.dequeueReusableCell(withIdentifier: temp)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: temp)
        }
        // FIX ME INDEX OUT OF RANGE ERROR
        cell?.textLabel?.text = myArray[indexPath.row]
        return cell!
    }
    
    
}

extension page2: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}




