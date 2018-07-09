//
//  TableViewCell.swift
//  ClimaTW
//
//  Created by 洪森達 on 2018/7/8.
//  Copyright © 2018年 sen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBOutlet weak var cityName: UILabel!
    
    
    @IBOutlet weak var summary: UILabel!
    
    
    @IBOutlet weak var temperature: UILabel!
    
    
    @IBOutlet weak var chanceOfR: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    
    func generate(tabel:CityName){
        
        if tabel != nil {
            iconImage.image = UIImage(named: tabel.icon!)
            
            cityName.text = tabel.city
            
            summary.text = tabel.summary
            
            temperature.text = convertValueToStringFromInt(double: tabel.tmeperature) + "℃"
            
            chanceOfR.text = String(tabel.chanceOfRain * 100 ) + "%"
            
            time.text = tabel.time
        }
        
     
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func convertValueToStringFromInt(double:Double)->String {
        
        
        let convert = Int(double - 32) * 5 / 9
        
        let convertString = String(convert)
        return convertString
        
        
    }
    
    
    

}
