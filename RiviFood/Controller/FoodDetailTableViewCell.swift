//
//  FoodDetailTableViewCell.swift
//  RiviFood
//
//  Created by mysmac_adm!n on 15/01/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit

class FoodDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var foodname: UILabel!
    @IBOutlet weak var describtion: UILabel!
    @IBOutlet weak var About: UILabel!
    @IBOutlet weak var whereToEat: UILabel!
    @IBOutlet weak var BestDishes: UILabel!
    
    @IBOutlet weak var Image1: UIImageView!
    @IBOutlet weak var Image2: UIImageView!
    @IBOutlet weak var Image3: UIImageView!
    @IBOutlet weak var Image4: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
