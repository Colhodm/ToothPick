//
//  page3.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/13/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit
import GooglePlaces

class page3: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var personTwos: UITextField!
    @IBOutlet weak var myOptions: UITableView!

    
    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    var myArray = [String]()
    var querylen = 4
    var distance: Int!
    var numPeople: Int!
    var myPlacesSoFar = [GooglePlaces.GMSPlace]()
    var placeNames = [String : GooglePlaces.GMSPlace]()
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
        self.locationManager.delegate = self
        self.placesClient = GMSPlacesClient.shared()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.myOptions.delegate = self
        self.myOptions.dataSource = self
        self.myOptions.isScrollEnabled = true;
        self.myOptions.isHidden = true;
        personTwos.addTarget(self, action: #selector(searchRecords(textField:)), for: .editingChanged)

        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func searchRecords(textField:UITextField){
        if personTwos.text!.count >= 4 {
            if personTwos.text!.count == 4{
                placeAutocomplete()
            }
            if self.querylen <= personTwos.text!.count{
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
    func filterArray(){
        var temp = [String]()
        for restaurant in myArray{
            if restaurant.contains(personTwos.text!){
                temp.append(restaurant)
            }
        }
        self.myArray = temp
        self.querylen = personTwos.text!.count
        
    }
    func placeAutocomplete() {
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery(personTwos.text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                // SHOULD FIX THIS SO IT MAKES LESS CALLS TO GOOGLE API SINCE WE"RE THROTTLED
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? landingpage
        {
            vc.distance = distance
            vc.numPeople = numPeople

            vc.myPlacesSoFar = self.myPlacesSoFar
        } else if let vc = segue.destination as? personthree{
            vc.distance = distance
            vc.numPeople = numPeople

            vc.myPlacesSoFar = self.myPlacesSoFar
        }
        print("finishes my segue")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension page3: UITableViewDelegate,UITableViewDataSource {
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
            personTwos.text = "Sorry, no matches were found please enter a new query"
            myOptions.isHidden = true
            return
        } else {
            personTwos.text = cell.textLabel?.text
            myPlacesSoFar.append(self.placeNames[(cell.textLabel?.text)!]!)
            myOptions.isHidden = true
            return
        }
    }
    
    
}

extension page3: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}

