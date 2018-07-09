//
//  ViewController.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/7.
//  Copyright © 2018年 sen. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import SVProgressHUD
import CoreData


class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate{
  
    
   
    var lat : Double?
    var lon: Double?
    var cityName:String?
    var hoursDate = [HoursDate]()
    var datesArray:[dates] = []
    var currentDates: currentDate?
    var locationManager = CLLocationManager()
    var isload:Bool = false
    var contextView = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var locallyLacetion: [UserLocation]?
  
   
    @IBOutlet weak var timezone: UILabel!
    
    @IBOutlet weak var icon: UILabel!
    
    
    @IBOutlet weak var precipPossibleLabel: UILabel!
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var currentTempreture: UILabel!
    
    
    @IBOutlet weak var currentSummary: UILabel!
    
    
    @IBOutlet weak var CurrentDate: UILabel!
    
    
    @IBOutlet weak var todayHighTempreture: UILabel!
    
    @IBOutlet weak var todayLowTempreture: UILabel!
    
    
    @IBOutlet weak var todayLabel0: UILabel!
    
    @IBOutlet weak var todayLabel1: UILabel!
    
    @IBOutlet weak var todayLabel2: UILabel!
    
    @IBOutlet weak var todayLabel3: UILabel!
    
    @IBOutlet weak var todayLabel4: UILabel!
    
    
    @IBOutlet weak var todayLabel5: UILabel!
    
    
    @IBOutlet weak var todayLabel6: UILabel!
    
    @IBOutlet weak var todayLabel7: UILabel!
    

    @IBOutlet weak var todayWeatherImageView0: UIImageView!
    
    @IBOutlet weak var todayWeatherImageView1: UIImageView!
    
    @IBOutlet weak var todayWeatherImageView2: UIImageView!
    
    
    @IBOutlet weak var todayWeatherImageView3: UIImageView!
    
    
    @IBOutlet weak var todayWeatherImageView4: UIImageView!
    
    
    @IBOutlet weak var todayWeatherImageView5: UIImageView!
    
    
    @IBOutlet weak var todayWeatherImageView6: UIImageView!
    
    
    @IBOutlet weak var todayWeatherImageView7: UIImageView!
    
    
    @IBOutlet weak var precipPosible0: UILabel!
    
    
    @IBOutlet weak var precipPosible1: UILabel!
    
    
    
    @IBOutlet weak var precipPosible2: UILabel!
    
    
    @IBOutlet weak var precipPosible3: UILabel!
    
    
    @IBOutlet weak var precipPosible4: UILabel!
    
    
    
    @IBOutlet weak var precipPosible5: UILabel!
    
    
    @IBOutlet weak var precipPosible6: UILabel!
    
    
    @IBOutlet weak var precipPosible7: UILabel!
    
    
    @IBOutlet weak var highTemp0: UILabel!
    
    
    @IBOutlet weak var highTemp1: UILabel!
    
    
    @IBOutlet weak var highTemp2: UILabel!
    
    
    @IBOutlet weak var highTemp3: UILabel!
    
    
    @IBOutlet weak var highTemp4: UILabel!
    
    
    @IBOutlet weak var highTemp5: UILabel!
    
    
    @IBOutlet weak var highTemp6: UILabel!
    
    
    @IBOutlet weak var highTemp7: UILabel!
    
    
    @IBOutlet weak var lowTemp0: UILabel!
    
    
    @IBOutlet weak var lowTemp1: UILabel!
    
    @IBOutlet weak var lowTemp2: UILabel!
    
    
    @IBOutlet weak var lowTemp3: UILabel!
    
    @IBOutlet weak var lowTemp4: UILabel!
    
    
    @IBOutlet weak var lowTemp5: UILabel!
    
    
    @IBOutlet weak var lowTemp6: UILabel!
    
    
    @IBOutlet weak var lowTemp7: UILabel!
    
    
    @IBOutlet weak var todaySumriseTime: UILabel!
    
    
    @IBOutlet weak var todaySunsetTime: UILabel!
    
    
    @IBOutlet weak var todayprecipPossibleLabel: UILabel!
    
    
    @IBOutlet weak var WindSpeed: UILabel!
    
    @IBOutlet weak var windGust: UILabel!
    
    @IBOutlet weak var uvIndex: UILabel!
    
    @IBOutlet weak var visibility: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    
    @IBOutlet weak var cloudCover: UILabel!
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
     
        
        return hoursDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.generate(hour: hoursDate[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73 , height: 74)
    }


    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
   
    override func viewWillLayoutSubviews() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        ScrollView.contentSize = CGSize(width: view.frame.width, height: mainView.frame.height + 10 )
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        if lat != nil && lon != nil && cityName != "" {
             locationManager.stopUpdatingLocation()
            newConditionWeather()
            isload = true
           
        }else{
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            isload = false
            
        }
        
      
    }

    //MARK: LocationDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        let location = locations[locations.count - 1]
     
       
        
        if location.horizontalAccuracy > 0 {
            
            manager.stopUpdatingLocation()
              SVProgressHUD.show()
            currentDate.forecast(withLocation: location) { (allJson) in
              
                let userLocaiton = UserLocation(context: self.contextView)
                userLocaiton.lat = location.coordinate.latitude
                userLocaiton.lon = location.coordinate.longitude
                self.locallyLacetion?.append(userLocaiton)
                self.saveDate()
                 self.retrieveHoursDate(json: allJson)
                DispatchQueue.main.async {
                    self.setupUicurrentDates(json: allJson)
                    self.setupDatesInWeek(json: allJson)
                  
                    self.collectionView.reloadData()
                     SVProgressHUD.dismiss()
                }
               
           
             
            }
            
            
       
        
        }
            
            
        }
    
    

    
        
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error is \(error.localizedDescription)")
        
    }
    
    
    func setupUicurrentDates(json:JSON){
        
        currentDates = currentDate.init(json: json)
        timezone.text = currentDates?.timeZone
       
        precipPossibleLabel.text = String((currentDates?.precipProbability)! * 100) + "%"
        currentTempreture.text = convertValueToStringFromInt(double: currentDates!.temperture)
        icon.text = currentDates?.icon
        if currentDates?.icon != nil {
            
            iconImageView.image = UIImage(named: currentDates!.icon)
        }
        
        

            
        }
    
    func setupDatesInWeek(json:JSON){
        
        for i in 0...7 {
        if let daily = json["daily"]["data"][i].dictionary {
            let new  = dates.init(daily)
            datesArray.append(new)
          
        }
        
    }
        
        
        let day0 = datesArray[0]
        let day1 = datesArray[1]
         let day2 = datesArray[2]
         let day3 = datesArray[3]
         let day4 = datesArray[4]
         let day5 = datesArray[5]
         let day6 = datesArray[6]
         let day7 = datesArray[7]
        
        // 0 section
        let MMMMDateFormmat = dateformmat()
        MMMMDateFormmat.dateFormat = "MMMM dd"
        let interval = switchTimeInterval1970(timestamp: day0.sunriseTime!)
        CurrentDate.text = dateformmat().string(from: interval)
        currentSummary.text = day0.Summery
        todayHighTempreture.text = convertValueToStringFromInt(double: day0.temperatureMax!)
        todayLowTempreture.text = convertValueToStringFromInt(double: day0.temperatureMin!)
        todayLabel0.text = MMMMDateFormmat.string(from: interval)
        todayWeatherImageView0.image = UIImage(named: day0.icon!)
        highTemp0.text = convertValueToStringFromInt(double: day0.temperatureMax!)
        lowTemp0.text = convertValueToStringFromInt(double: day0.temperatureMin!)
        if day0.precipProbability! * 100 > 30  {
            precipPosible0.isHidden = false
            precipPosible0.text = String(day0.precipProbability! * 100) + "%"
           
        }else{
            precipPosible0.isHidden = true
            precipPosible0.text = String(day0.precipProbability! * 100) + "%"
        }
        
        
        
        
  

        // weather INFO
        let riseFommater = dateformmat()
        riseFommater.dateFormat = "HH:mm a"
        todaySumriseTime.text = riseFommater.string(from: switchTimeInterval1970(timestamp: day0.sunriseTime!))
        todaySunsetTime.text = riseFommater.string(from: switchTimeInterval1970(timestamp: day0.sunsetTime!))
        todayprecipPossibleLabel.text = String(day0.precipProbability! * 100) + "%"
        WindSpeed.text = String(Int(day0.windSpeed!)) + " mph"
        windGust.text = String(Int(day0.windGust!)) + " mph"
        uvIndex.text = String(Int(day0.UvIndex!)) + " +"
        visibility.text = String(Int(day0.visibility!)) + " mi"
        humidity.text = String(day0.humidity! * 100) + "%"
        cloudCover.text = String(day0.cloudCover! * 100) + "%"
  
   
        todayLabel1.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day1.sunsetTime!))
        todayLabel2.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day2.sunsetTime!))
        todayLabel3.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day3.sunsetTime!))
        todayLabel4.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day4.sunsetTime!))
        todayLabel5.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day5.sunsetTime!))
        todayLabel6.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day6.sunsetTime!))
        todayLabel7.text = MMMMDateFormmat.string(from: switchTimeInterval1970(timestamp: day7.sunsetTime!))

        todayWeatherImageView1.image = UIImage(named: day1.icon!)
        todayWeatherImageView2.image = UIImage(named: day2.icon!)
        todayWeatherImageView3.image = UIImage(named: day3.icon!)
        todayWeatherImageView4.image = UIImage(named: day4.icon!)
        todayWeatherImageView5.image = UIImage(named: day5.icon!)
        todayWeatherImageView6.image = UIImage(named: day6.icon!)
        todayWeatherImageView7.image = UIImage(named: day7.icon!)
        
    
        if day1.precipProbability! * 100 > 30  {
            precipPosible1.isHidden = false
            precipPosible1.text = String(day1.precipProbability! * 100) + "%"
            
        }else{
            precipPosible1.isHidden = true
            precipPosible1.text = String(day1.precipProbability! * 100) + "%"
        }
        
        if day2.precipProbability! * 100 > 30  {
            precipPosible2.isHidden = false
            precipPosible2.text = String(day2.precipProbability! * 100) + "%"
            
        }else{
            precipPosible2.isHidden = true
            precipPosible2.text = String(day2.precipProbability! * 100) + "%"
        }
        
        if day3.precipProbability! * 100 > 30  {
            precipPosible3.isHidden = false
            precipPosible3.text = String(day3.precipProbability! * 100) + "%"
            
        }else{
            precipPosible3.isHidden = true
            precipPosible3.text = String(day3.precipProbability! * 100) + "%"
        }
        
        if day4.precipProbability! * 100 > 30  {
            precipPosible4.isHidden = false
            precipPosible4.text = String( day4.precipProbability! * 100) + "%"
            
        }else{
            precipPosible4.isHidden = true
            precipPosible4.text = String( day4.precipProbability! * 100) + "%"
        }
        
        
        if day5.precipProbability! * 100 > 30  {
            precipPosible5.isHidden = false
            precipPosible5.text = String(day5.precipProbability! * 100) + "%"
            
        }else{
            precipPosible5.isHidden = true
            precipPosible5.text = String(day5.precipProbability! * 100) + "%"
        }
        
        if day6.precipProbability! * 100 > 30  {
            precipPosible6.isHidden = false
            precipPosible6.text = String(day6.precipProbability! * 100) + "%"
            
        }else{
            precipPosible6.isHidden = true
            precipPosible6.text = String(day6.precipProbability! * 100) + "%"
        }
        
        if day7.precipProbability! * 100 > 30  {
            precipPosible7.isHidden = false
            precipPosible7.text = String(day7.precipProbability! * 100) + "%"
            
        }else{
            precipPosible7.isHidden = true
            precipPosible7.text = String(day7.precipProbability! * 100) + "%"
        }

        highTemp1.text = convertValueToStringFromInt(double: day1.temperatureMax!)
        lowTemp1.text = convertValueToStringFromInt(double: day1.temperatureMin!)
        
        highTemp2.text = convertValueToStringFromInt(double: day2.temperatureMax!)
        lowTemp2.text = convertValueToStringFromInt(double: day2.temperatureMin!)
        
        highTemp3.text = convertValueToStringFromInt(double: day3.temperatureMax!)
        lowTemp3.text = convertValueToStringFromInt(double: day3.temperatureMin!)
        
        highTemp4.text = convertValueToStringFromInt(double: day4.temperatureMax!)
        lowTemp4.text = convertValueToStringFromInt(double: day4.temperatureMin!)
        
        highTemp5.text = convertValueToStringFromInt(double: day5.temperatureMax!)
        lowTemp5.text = convertValueToStringFromInt(double: day5.temperatureMin!)
        
        highTemp6.text = convertValueToStringFromInt(double: day6.temperatureMax!)
        lowTemp6.text = convertValueToStringFromInt(double: day6.temperatureMin!)
        
        highTemp7.text = convertValueToStringFromInt(double: day7.temperatureMax!)
        lowTemp7.text = convertValueToStringFromInt(double: day7.temperatureMin!)
        

        
}
    
    
    func retrieveHoursDate(json:JSON){
        
        for i in 0...23 {
                
                if let hours = json["hourly"]["data"][i].dictionary {
     
                    let newhour = HoursDate.init(hours)
                    
                     hoursDate.append(newhour)
                    
                    }
            }
        
     
        
        

    }
    
    func newConditionWeather() {
        
        
        currentDate.forecast(withLocation: CLLocation(latitude: lat!, longitude: lon!)) { (alljosn) in
            
            
            if alljosn != nil {
                
                
                SVProgressHUD.show()
                  self.retrieveHoursDate(json: alljosn)
                DispatchQueue.main.async {
                    self.setupUicurrentDates(json: alljosn)
                    self.setupDatesInWeek(json: alljosn)
                    self.timezone.text = self.cityName
                    self.collectionView.reloadData()
                    SVProgressHUD.dismiss()
                }
                
            }
        }
        
        
        
    }
    
  
    

    
  
   
   
    

    
        
    //MARK: - helper
    func convertValueToStringFromInt(double:Double)->String {
        
        
        let convert = Int(double - 32) * 5 / 9
        
        let convertString = String(convert)
        return convertString
        
        
    }
    

    
    
    
    

      
        
        
 
    @IBAction func gotoTabel(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
      self.present(vc, animated: true, completion: nil)
        
    }
    
    
    func saveDate() {
        
        
        do {
            
            try contextView.save()
        }catch{
            print("cann't save date")
            
        }
        
          collectionView.reloadData()
        
    }
    
    func loadDate(WITH Requset:NSFetchRequest<UserLocation> = UserLocation.fetchRequest()){
        
        
        do {
            
            locallyLacetion = try contextView.fetch(Requset)
            
            
        }catch{
            
            print("Error saving context in fetch \(error)")
        }
        
        collectionView.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
    
    

    

    
    
    






//25.038504, 121.285553
//edf3ff91f9444159901726f7c329c9fb
