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
class ViewController: UIViewController {
    // 1
    let eventStore = EKEventStore()
    var calanderKeys:[String:String] = [:]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
           // insertEvent(store: eventStore)
            fetchEventsFromCalendar(calendarTitle: "Harsh")
        case .denied:
            print("Access denied")
        case .notDetermined:
            // 3
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        self!.insertEvent(store: self!.eventStore)
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case default")
        }
       // assignLocalizestring(key: "Welcome", label: welcomeMessageLbl)
        // Do any additional setup after loading the view.
    }

    func insertEvent(store: EKEventStore) {
        // 1
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            // 2
            calendar.title = "Harsh Meeting"
            if calendar.title == "Harsh Meeting" {
               
                // 3
                let startDate = Date()
                // 2 hours
                let endDate = startDate.addingTimeInterval(72 * 60 * 60)
                
                // 4
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "New Meeting with Peter"
                event.startDate = startDate
                event.endDate = endDate
                // 5
                do {
                    try store.save(event, span: .thisEvent)
                    fetchEventsFromCalendar(calendarTitle: "Harsh Meeting")
                }
                catch {
                    print("Error saving event in calendar")             }
            }
        }
    }
    func fetchEventsFromCalendar(calendarTitle: String) -> Void {
        let calendars = eventStore.calendars(for: .event)
        for calendar:EKCalendar in calendars {
             calanderKeys.updateValue(calendar.title, forKey: calendar.calendarIdentifier)
           // if calendar.title == calendarTitle {
//                let selectedCalendar = calendar
//
//                let startDate = NSDate()
//                let endDate = NSDate(timeIntervalSinceNow: 60*60*24*30)
//                let predicate = eventStore.predicateForEvents(withStart: startDate as Date, end: endDate as Date, calendars: [selectedCalendar])
//                let events = eventStore.events(matching: predicate) as [EKEvent]
//
//                print("Events: \(events)")
//                for event in events {
//                    print("Event Title : \(event.title) Event ID: \(event.eventIdentifier)")
//                }
            
            //}
        }
        print(calanderKeys)
        //MARK: Output
//        Events: [EKEvent <0x6000035eb450>
//        {
//        EKEvent <0x6000035eb450>
//        {     title =         New Meeting with Peter;
//        location =     ;
//        calendar =     EKCalendar <0x600001289380> {title = Harsh Meeting; type = Local; allowsModify = YES; color = #1BADF8;};
//        alarms =         (null);
//        URL =             (null);
//        lastModified = (null);
//        startTimeZone =     America/Toronto (EDT) offset -14400 (Daylight);
//        startTimeZone =     America/Toronto (EDT) offset -14400 (Daylight)
//        };
//        location =     ;
//        structuredLocation =     (null);
//        startDate =     2019-06-16 14:28:36 +0000;
//        endDate =         2019-06-19 14:28:36 +0000;
//        allDay =         0;
//        floating =     0;
//        recurrence =     (null);
//        attendees =     (null);
//        travelTime =     (null);
//        startLocation =     (null);
//        };, EKEvent <0x6000035ebb10>
//        {
//        EKEvent <0x6000035ebb10>
//        {     title =         New Meeting with client;
//        location =     ;
//        calendar =     EKCalendar <0x6000012891c0> {title = Harsh Meeting; type = Local; allowsModify = YES; color = #1BADF8;};
//        alarms =         (null);
//        URL =             (null);
//        lastModified = 2019-06-16 14:23:56 +0000;
//        startTimeZone =     America/Toronto (EDT) offset -14400 (Daylight);
//        startTimeZone =     America/Toronto (EDT) offset -14400 (Daylight)
//        };
//        location =     ;
//        structuredLocation =     (null);
//        startDate =     2019-06-17 14:23:55 +0000;
//        endDate =         2019-06-17 16:23:55 +0000;
//        allDay =         0;
//        floating =     0;
//        recurrence =     (null);
//        attendees =     (null);
//        travelTime =     (null);
//        startLocation =     (null);
//        };]
//        Event Title : Optional("New Meeting with Peter") Event ID: Optional("454DD52D-5702-434F-AE20-EC4518EDAD12:8CB52277-FCEC-436E-AEBE-70FD957378DE")
//        Event Title : Optional("New Meeting with client") Event ID: Optional("454DD52D-5702-434F-AE20-EC4518EDAD12:6F8CC8FD-671D-482E-AE32-9962B6BD9639")
//        (lldb)
       print(pineapplesCountUniversal(count: 0))
        print(pineapplesCountUniversal(count: 1))
        print(pineapplesCountUniversal(count: 2))
        print(pineapplesCountUniversal(count: 3))
    }
    private func pineapplesCountUniversal(count: UInt) -> String{
        
        let formatString : String = NSLocalizedString("your total calender", comment: "your total calenderr")
        
        let resultString : String = String.localizedStringWithFormat(formatString,count)
        return resultString;
    }
    
}
extension ViewController{
    func assignLocalizestring(key:String,label:UILabel!)
    {
        DispatchQueue.main.async {
            label.text = NSLocalizedString(key, comment: "")
        }
        
    }
}
