//
//  CollectionViewCell.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/8.
//  Copyright © 2018年 sen. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var precip: UILabel!
    
    
    @IBOutlet weak var temperature: UILabel!
    
    
    
    func generate(hour:HoursDate) {
        
        
        if hour.icon != "" {
            
            iconImage.image = UIImage(named: hour.icon!)
            
        }else{
            
            iconImage.image  = UIImage(named: "overcast")
        }
        
        if hour.temperature != 0.0 {
            
            temperature.text = convertValueToStringFromInt(double: hour.temperature!) + "℃"
            
        }else{
            
            temperature.text = "0.0℃"
        }
        
        if hour.time != 0.0 {
            
            let tempTime = switchTimeInterval1970(timestamp: hour.time!)
            
            let AmDate = dateformmat()
            
            AmDate.dateFormat = "HH a"
            
            time.text = AmDate.string(from: tempTime)
        }
        
        if hour.precipProbalbility! * 100 > 30 {
            
            precip.isHidden = false
            precip.text = String(hour.precipProbalbility! * 100) + "%"
        }
        
        
        
        
    }
    
    
    func convertValueToStringFromInt(double:Double)->String {
        
        
        let convert = Int(double - 32) * 5 / 9
        
        let convertString = String(convert)
        return convertString
        
        
    }

    
    
    
}
