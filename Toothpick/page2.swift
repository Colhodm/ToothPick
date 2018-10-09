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
    var querylen = 4
    var myPlacesSoFar = [GooglePlaces.GMSPlace]()
    var placeNames = [String : GooglePlaces.GMSPlace]()



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
        if personOne.text!.count >= 4 {
            if personOne.text!.count == 4{
                placeAutocomplete()
            }
            if self.querylen <= personOne.text!.count{
                filterArray()
            } else {
                placeAutocomplete()

            }
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
            vc.myPlacesSoFar = self.myPlacesSoFar
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
    
    func filterArray(){
        var temp = [String]()
        for restaurant in myArray{
            if restaurant.contains(personOne.text!){
                temp.append(restaurant)
            }
        }
        self.myArray = temp
        self.querylen = personOne.text!.count
        
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
                self.myArray = [String]()
                for result in results {
                    self.myArray.append(result.attributedPrimaryText.string)
                    self.placesClient.lookUpPlaceID(result.placeID!, callback: { (place, error) -> Void in
                        if let error = error {
                            print("lookup place id query error: \(error.localizedDescription)")
                            return
                        }
                        guard let place = place else {
                            print("No place details for \(result.placeID!)")
                            return
                        }
                        self.placeNames[result.attributedPrimaryText.string] = place
                    })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let cell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        if cell.textLabel?.text?.count == 0{
            personOne.text = "Sorry, no matches were found please enter a new query"
            myOptions.isHidden = true
            return
        } else {
            personOne.text = cell.textLabel?.text
            myOptions.isHidden = true
            myPlacesSoFar.append(self.placeNames[(cell.textLabel?.text)!]!)
            return
        }
    }
    
    
}

extension page2: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}




