//
//  helper.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/7.
//  Copyright © 2018年 sen. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

func dateformmat()->DateFormatter {
    
    
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    
    return dateFormatter
    
}

func switchTimeInterval1970(timestamp:Double)->Date {
    
    
   let timeInterval = Date(timeIntervalSince1970: timestamp)

    
    return timeInterval
}

func convertValueToStringFromInt(double:Double)->String {
    
    
    let convert = Int(double - 32) * 5 / 9
    
    let convertString = String(convert)
    return convertString
    

    
}





















