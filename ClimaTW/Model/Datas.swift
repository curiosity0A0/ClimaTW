//
//  Datas.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/7.
//  Copyright © 2018年 sen. All rights reserved.
//

import Foundation
import SwiftyJSON


struct dates {
    
   var Summery: String? = ""
    var icon:String? = ""
    var temperatureMax:Double? = 0.0
    var temperatureMin:Double? = 0.0
    var precipProbability:Double? = 0.0
    var sunriseTime:Double? = 0.0
    var sunsetTime: Double? = 0.0
    var windSpeed: Double? = 0.0
    var windGust:Double? = 0.0
    var UvIndex: Double? = 0.0
    var visibility:Double? = 0.0
    var humidity:Double? = 0.0
    var cloudCover:Double? = 0.0
    
    init(_ jsonFromDaily:[String:JSON]) {
   
        Summery = jsonFromDaily["summary"]?.stringValue
        icon = jsonFromDaily["icon"]?.stringValue
        temperatureMax = jsonFromDaily["temperatureMax"]?.doubleValue
        temperatureMin = jsonFromDaily["temperatureMin"]?.doubleValue
        precipProbability = jsonFromDaily["precipProbability"]?.doubleValue
        sunriseTime = jsonFromDaily["sunriseTime"]?.doubleValue
        sunsetTime = jsonFromDaily["sunsetTime"]?.doubleValue
            windSpeed = jsonFromDaily["windSpeed"]?.doubleValue
            windGust = jsonFromDaily["windGust"]?.doubleValue
            UvIndex = jsonFromDaily["uvIndex"]?.doubleValue
            visibility = jsonFromDaily["visibility"]?.doubleValue
            humidity = jsonFromDaily["humidity"]?.doubleValue
            cloudCover = jsonFromDaily["cloudCover"]?.doubleValue


        
    }
}
