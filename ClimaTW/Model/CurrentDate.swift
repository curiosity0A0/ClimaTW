//
//  CurrentDate.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/7.
//  Copyright © 2018年 sen. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import Alamofire

struct currentDate{
    
    
    //https://api.darksky.net/forecast/0123456789abcdef9876543210fedcba/42.3601,-71.0589,255657600?exclude=currently,flags

    var timeZone: String
    var headerSummary:String
    var icon: String
    var precipProbability: Double
    var temperture: Double
    var currently:[String:Any]
 
    init(json:JSON) {
       
        if  json != nil {
        
        timeZone = json["timezone"].string!
        currently = json["currently"].dictionary!
        headerSummary = json["currently"]["summary"].string!
        icon = json["currently"]["icon"].string!
        precipProbability = json["currently"]["precipProbability"].double!
        temperture =  json["currently"]["temperature"].double!
       
       
        }else{
            
            timeZone = ""
                currently = [:]
            headerSummary = ""
            icon = ""
            precipProbability = 0.0
            temperture = 0.0
            
            
            
            
            
            print("cann'parser json")
        }
     
      
    
        
    }
    
     static let basePath =  "https://api.darksky.net/forecast/edf3ff91f9444159901726f7c329c9fb/"
    
    static func forecast (withLocation location: CLLocation , completion: @escaping (_ json: JSON) -> () ) {
   
        let url = basePath + "\(location.coordinate.latitude),\(location.coordinate.longitude)"
             print(url)
        Alamofire.request(url, method: .get, parameters:nil).responseJSON { (responese) in
            
            let wheatherJson:JSON = JSON(responese.result.value)
            
            completion(wheatherJson)
            
            
        }
        
        
    }
    
    

    
    

}
