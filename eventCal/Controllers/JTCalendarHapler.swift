//
//  JTCalendarHapler.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-07-06.
//  Copyright © 2019 FitFi. All rights reserved.
//

import Foundation
import JTAppleCalendar

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
            validCell.selectedView.backgroundColor = PRIMARY_COLOR
        }
        else{
            if(cellState.dateBelongsTo == .thisMonth)
            {
                validCell.dateLabel.textColor = UIColor.black
                validCell.selectedView.backgroundColor = SECONDARY_COLOR
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
            //update table view
            if (validCell.events.count > 0)
            {
                print(validCell.events)
            }
            
        }
        else{
            
            // validCell.selectedView.isHidden = true
        }
        
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard cell is CalenderCell else {return}
        
    }
    
    //func setupViewOfCalender()
    ///MARK: configure here for calender view.
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = Calendar.current.date(byAdding: .month, value: 0, to: Date())
        let endDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        
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
        cell.events = fetchEvents(calendarTitle: calendarTitle, forDate: date)
        if(comapreDate == todayDateStr)
        {
            todayFlag = 1
        }
        else if(cell.events != [])
        {
            eventFlag = 1
        }
        cell.selectedView.layer.cornerRadius = cell.selectedView.frame.height / 2
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelected(view: cell, cellState: cellState)
        updateTableEvents(date:date)
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    
}


