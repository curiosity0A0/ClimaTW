//
//  HoursDate.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/7.
//  Copyright © 2018年 sen. All rights reserved.
//

import Foundation
import SwiftyJSON


struct HoursDate {
    
    var temperature: Double? = 0.0
    var icon: String? = ""
    var time: Double? = 0.0
    var precipProbalbility:Double? = 0.0
    
    init(_ json:[String:JSON]){
        
        if json != nil {
            
            temperature = json["temperature"]?.doubleValue
            icon = json["icon"]?.stringValue
            time = json["time"]?.doubleValue
            precipProbalbility = json["precipProbability"]?.doubleValue
  
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}
