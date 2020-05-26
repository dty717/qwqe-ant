//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by dty on 2018/10/1.
//  Copyright © 2018年 dty. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    @IBOutlet weak var Rating_control: RatingControl!
    @IBOutlet weak var Name_view: UILabel!
    @IBOutlet weak var Image_view: UIImageView!
}
