//
//  CalenderCell.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-07-01.
//  Copyright © 2019 FitFi. All rights reserved.
//

import UIKit
import JTAppleCalendar
import EventKit
class CalenderCell: JTAppleCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    var events:[EKEvent] = []
}
