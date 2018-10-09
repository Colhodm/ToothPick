//
//  personthree.swift
//  Toothpick
//
//  Created by ananya mukerjee on 9/20/18.
//  Copyright © 2018 Cheney. All rights reserved.
//

import UIKit
import GooglePlaces
class personfive: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var myOptions: UITableView!
    @IBOutlet weak var personFiveText: UITextField!
    var distance: Int!
    var numPeople: Int!

    
    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    var myArray = [String]()
    var querylen = 4
    var myPlacesSoFar = [GooglePlaces.GMSPlace]()
    var placeNames = [String : GooglePlaces.GMSPlace]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personFiveText.delegate = self
        self.locationManager.delegate = self
        self.placesClient = GMSPlacesClient.shared()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.myOptions.delegate = self
        self.myOptions.dataSource = self
        self.myOptions.isScrollEnabled = true;
        self.myOptions.isHidden = true;
        personFiveText.addTarget(self, action: #selector(searchRecords(textField:)), for: .editingChanged)


        // Do any additional setup after loading the view.
    }
    @objc func searchRecords(textField:UITextField){
        if personFiveText.text!.count >= 4 {
            if personFiveText.text!.count == 4{
                placeAutocomplete()
            }
            if self.querylen <= personFiveText.text!.count{
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
            if restaurant.contains(personFiveText.text!){
                temp.append(restaurant)
            }
        }
        self.myArray = temp
        self.querylen = personFiveText.text!.count
        
    }
    func placeAutocomplete() {
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        placesClient.autocompleteQuery(personFiveText.text!, bounds: nil, filter: filter, callback: {(results, error) -> Void in
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func toTap(_ sender: Any) {
    if numPeople! > 5  {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personfivetopersonsix", sender: self)
            
        } else {
            /*Use the Identifier you given in story Board*/
            self.performSegue(withIdentifier: "personfivetoend", sender: self)
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
            vc.myPlacesSoFar = self.myPlacesSoFar

        } else if let vc = segue.destination as? personsix{
            vc.distance = distance
            vc.numPeople = numPeople
            vc.myPlacesSoFar = self.myPlacesSoFar

        }
    }
}
extension personfive: UITableViewDelegate,UITableViewDataSource {
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
            personFiveText.text = "Sorry, no matches were found please enter a new query"
            myOptions.isHidden = true
            return
        } else {
            personFiveText.text = cell.textLabel?.text
            myPlacesSoFar.append(self.placeNames[(cell.textLabel?.text)!]!)

            myOptions.isHidden = true
            return
        }
    }
    
    
}

extension personfive: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    }
}





