//
//  TrackerTableViewCell.swift
//  Zwaste
//
//  Created by Braxton Madison on 12/5/18.
//  Copyright © 2018 GeorgiaTech. All rights reserved.
//

import UIKit

class TrackerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    
    //MARK: Properties
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellType: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
