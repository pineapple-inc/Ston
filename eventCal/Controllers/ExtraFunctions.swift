//
//  ExtraFunctions.swift
//  eventCal
//
//  Created by Harsh_Dev on 2019-07-06.
//  Copyright © 2019 FitFi. All rights reserved.
//

import Foundation
import UIKit
extension ViewController{
    
    
    ///MARK: Date Function
    //TBD
    func getDayStartEnd(date:Date) -> [Date]
    {
        let startDate:Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of:date)!
        let endDate:Date = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
        return [startDate,endDate]
    }
    private func pineapplesCountUniversal(count: UInt) -> String{
        
        let formatString : String = NSLocalizedString("your total calender", comment: "your total calenderr")
        
        let resultString : String = String.localizedStringWithFormat(formatString,count)
        return resultString;
    }
    func assignLocalizestring(key:String,label:UILabel!)
    {
        DispatchQueue.main.async {
            label.text = NSLocalizedString(key, comment: "")
        }
        
    }
    
    func updateTableEvents(date:Date){
        let events = fetchEvents(calendarTitle: CURRENT_CALENDER, forDate: date)
        self.eventObjOnDate = []
        
        for i in events{
            
            self.eventObjOnDate.append(i)
           }
        self.eventList.reloadData()
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
