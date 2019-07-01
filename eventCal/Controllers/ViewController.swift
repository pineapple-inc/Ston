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
    let boarderColor:CGColor = UIColor(red: 61/255, green: 197/255, blue: 202/255, alpha: 1).cgColor
    
    let eventStore = EKEventStore()
    var calanderKeys:[String:String] = [:]
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
//        switch EKEventStore.authorizationStatus(for: .event) {
//        case .authorized:
//           // insertEvent(store: eventStore)
//            fetchEventsFromCalendar(calendarTitle: "Harsh")
//        case .denied:
//            print("Access denied")
//        case .notDetermined:
//            // 3
//            eventStore.requestAccess(to: .event, completion:
//                {[weak self] (granted: Bool, error: Error?) -> Void in
//                    if granted {
//                        self!.insertEvent(store: self!.eventStore)
//                    } else {
//                        print("Access denied")
//                    }
//            })
//        default:
//            print("Case default")
//        }
      //  self.view.isOpaque = false
        setupCalender()
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
extension ViewController : JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource
{
    func setupCalender(){
        calendarView.visibleDates{(visibleDates) in
            self.setupViewsOfCalender(visibleDates: visibleDates)
        }
    }
    func setupViewsOfCalender(visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        print(self.formatter.string(from: date))
       // self.CalenderTitleOutlet.title = self.formatter.string(from: date)
        self.formatter.dateFormat = "MMMM"
      //  self.CalenderTitleOutlet.title  = self.formatter.string(from: date) + " " + self.CalenderTitleOutlet.title!
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
       
    }
    func handleCellTextColor(view: JTAppleCell?,cellState:CellState)
    {
        guard let validCell = view as? CalenderCell else {return}
        if(cellState.isSelected)
        {
            validCell.dateLabel.textColor = UIColor.black
        }
        else{
            if(cellState.dateBelongsTo == .thisMonth)
            {
                validCell.dateLabel.textColor = UIColor.black
                if(todayFlag == 1)
                {
                    todayFlag = 0
                    validCell.dateLabel.textColor = UIColor.yellow
                    
                    validCell.dateLabel.underline()
                }
                else if(eventFlag == 1)
                {
                    eventFlag = 0
                    validCell.dateLabel.textColor = UIColor.green
                    validCell.selectedView.isHidden = false
                    validCell.selectedView.backgroundColor = UIColor.clear
                    validCell.layer.borderWidth = 1
                    validCell.layer.borderColor = boarderColor
                    
                }
            }
            else{
                validCell.dateLabel.textColor = UIColor.blue
            }
            
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalender(visibleDates: visibleDates)    }
    
    func handleCellSelected(view: JTAppleCell?,cellState:CellState)
    {
        guard let validCell = view as? CalenderCell else {return}
        
        if(cellState.isSelected)
        {
            
            validCell.selectedView.isHidden = false
            
        }
        else{
            
           // validCell.selectedView.isHidden = true
        }
        
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard cell is CalenderCell else {return}
        
    }
    
    //func setupViewOfCalender()
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        let endDate = Calendar.current.date(byAdding: .month, value: 11, to: Date())
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        calendar.scrollToDate(Date())
        return parameters
    }
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCell
        cell.dateLabel.text = cellState.text
        var comapreDate:String = " "
        var todayDateStr:String = " "
        self.formatter.dateFormat = "yyyy/MM/dd"
        comapreDate = formatter.string(from: date)
        todayDateStr = formatter.string(from: todayDate)
        
        if(comapreDate == todayDateStr)
        {
            todayFlag = 1
        }
        else if(dateArr.contains(comapreDate))
        {
            eventFlag = 1
        }
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelected(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    
}

extension UILabel{
    
    func makeOutLine(oulineColor: UIColor, foregroundColor: UIColor){
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : oulineColor,
            NSAttributedString.Key.foregroundColor : foregroundColor,
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : self.font
            ] as [NSAttributedString.Key : Any]
        self.attributedText = NSMutableAttributedString(string: self.text ?? "", attributes: strokeTextAttributes)
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString); attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

