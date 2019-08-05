//
//  ViewController.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-06-16.
//  Copyright © 2019 FitFi. All rights reserved.
//

import UIKit
import EventKit
import JTAppleCalendar
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    // 1
    let boarderColor:CGColor = UIColor(red: 61/255, green: 197/255, blue: 202/255, alpha: 1).cgColor
    var eventObjOnDate:[EKEvent] = []
    let calendarTitle:String = "Harsh Meeting"
    let cellId = "eventCell"
    let nibNamee = "eventCell"
    let eventStore = EKEventStore()
    var eventSelected:EKEvent!
    var calanderKeys:[String:String] = [:]
    @IBOutlet weak var eventList: UITableView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = DateFormatter()
    var eventFlag:Int = 0
    var todayFlag:Int = 0
    var todayDate:Date = Date()
     var dateArr:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        todayDate = Date()
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            //insertEvent(store: eventStore)
            fetchEventsFromCalendar(calendarTitle: "Harsh Meeting")
        case .denied:
            print("Access denied")
        case .notDetermined:
            // 3
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                       // self!.insertEvent(store: self!.eventStore)
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case default")
        }
        self.view.isOpaque = false
        //eventList.register(eventCell.self, forCellReuseIdentifier: cellId)
        eventList.register(UINib.init(nibName: nibNamee, bundle: nil), forCellReuseIdentifier: cellId)
        eventList.delegate = self
        eventList.dataSource = self
        setupCalender()
       // assignLocalizestring(key: "Welcome", label: welcomeMessageLbl)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventObjOnDate.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! eventCell
        
        cell.eventTypeColor.backgroundColor = .red
        cell.currentEvent = eventObjOnDate[indexPath.row]
        eventSelected = cell.currentEvent
        if let title = cell.currentEvent.title
        {
            cell.EventName!.text = title
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "eventVC")
        {
            if let vc = segue.destination as? EditInvoiceViewController{
                vc.currentEvent = eventSelected
            }
        }
    }
  
}


