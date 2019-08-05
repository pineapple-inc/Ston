//
//  eventCell.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-07-01.
//  Copyright © 2019 FitFi. All rights reserved.
//

import UIKit
import EventKit
class eventCell: UITableViewCell {

    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var eventTypeColor: UIView!
    var currentEvent:EKEvent!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
