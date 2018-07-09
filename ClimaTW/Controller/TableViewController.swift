//
//  TableViewController.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/8.
//  Copyright © 2018年 sen. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import SwiftyJSON
import Alamofire
import CoreData




class TableViewController: UITableViewController,UISearchBarDelegate{
    
    
   
    var cityName: [CityName] = []
    var contextView = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            SVProgressHUD.show()
            updateWeatherByCityName(locationSring: locationString)
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          loadDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
//        updateWeatherByCityName(locationSring: "New York")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        self.tableView.tableFooterView = UIView()
        self.searchBar.placeholder = "Please Enter Country"
        
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  cityName.reversed().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.generate(tabel: cityName[indexPath.row])
        
        return cell
    }
    
    
    //TableView delegate
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actiom = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            
            self.contextView.delete(self.cityName[index.row])
            self.cityName.remove(at: index.row)
            
            self.saveDate()
            
            tableView.reloadData()
            
            
        }
        
        return [actiom]
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goback", sender: self)
        
        
        
     
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goback" {
            
            if let destination = segue.destination as? ViewController{
                
                if let index = tableView.indexPathForSelectedRow?.row{
                    
                    destination.cityName = cityName[index].city
                    destination.lat = cityName[index].latitude
                    destination.lon = cityName[index].longitude
                }
            }
            
       
            
        }
    }
    
    
    func forCity(){
     
        
        if (cityName.count) > 0 {
            
            for city in cityName {
                
                
                updateWeatherByCityName(locationSring: city.city!)
                
                
            }
            
            
        }

        
        
    }
    
    
    func updateWeatherByCityName(locationSring: String){
        
        CLGeocoder().geocodeAddressString(locationSring) { (placemarks, error) in
            if error == nil {
                
                if let locaiton = placemarks?.first?.location {
                    
                    currentDate.forecast(withLocation: locaiton, completion: { (alljson) in
                        
                        if alljson != nil {
                            
                         let newCity = CityName(context: self.contextView)
                             newCity.summary = alljson["daily"]["summary"].stringValue
                            newCity.icon = alljson["currently"]["icon"].stringValue
                            newCity.chanceOfRain  = alljson["currently"]["precipIntensity"].doubleValue
                             newCity.tmeperature = alljson["currently"]["temperature"].doubleValue
                             let time = alljson["currently"]["time"].doubleValue
                            let date = switchTimeInterval1970(timestamp: time)
                           newCity.time = dateformmat().string(from: date)
                           newCity.latitude = alljson["latitude"].doubleValue
                            newCity.longitude = alljson["longitude"].doubleValue
                            self.getCityName(lat: newCity.latitude, lon: newCity.longitude, completion: { (cityName) in
                                print(cityName)
                                newCity.city = cityName
                                self.saveDate()
                            })
                     
                            
                            self.cityName.append(newCity)
                            self.saveDate()
                              print(newCity)
                         
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                }
            }else{
                
                print("the city is not exist")
            }
        }
        
    }
    
    func saveDate() {
        
        
        do {
            
          try contextView.save()
        }catch{
            print("cann't save date")
            
        }
        
            tableView.reloadData()
        
    }
    
    func loadDate(WITH Requset:NSFetchRequest<CityName> = CityName.fetchRequest()){
        
        
        do {
            
            cityName = try contextView.fetch(Requset)
            
            
        }catch{
            
            print("Error saving context in fetch \(error)")
        }
        
        tableView.reloadData()

    }
    
    
    
    func getCityName(lat:Double,lon:Double ,completion: @escaping (_ CityName: String) -> Void){
       
  
        let gecoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        gecoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if error != nil {
                
                print("error in here")
            }
            
            if let p = placeMark?[0] {
            
                guard let city = p.locality else { return }
                guard let country = p.country else { return }
    
                completion(country + "/" + city)
            }
            
        }
        
    }
    


}
