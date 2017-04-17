//
//  XZDataPickerView.swift
//  PeopleLight
//
//  Created by 典爆mac on 2017/4/10.
//  Copyright © 2017年 smartit. All rights reserved.
//

import UIKit

class XZDataPickerView: UIView {

    var datePicker : UIDatePicker!
    var cancelBtn : UIButton!
    var sureBtn : UIButton!
    var timeLab : UILabel!
    var backgroundView : UIView!
    
    var sureAction:(parament:AnyObject)->() = ({_ in
        
    })
    var cancelAction:(parament:AnyObject)->() = ({_ in
        
    })
    

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        self.datePicker = UIDatePicker()
        self.datePicker.center = CGPointMake(self.center.x, self.frame.size.height - self.datePicker.frame.size.height / 2 - 40)
        self.addSubview(self.datePicker)
        
        self.datePicker.addTarget(self,
                                  action: #selector(self.datePickerDateChanged(_:)),
                                  forControlEvents: .ValueChanged)
        
        
        let oneYearTime:NSTimeInterval = 365 * 24 * 60 * 60
        let todayDate = NSDate()
        let oneYearFromToday = todayDate.dateByAddingTimeInterval(oneYearTime)
        let twoYearsFromToday = todayDate.dateByAddingTimeInterval(2 * oneYearTime)
        self.datePicker.minimumDate = oneYearFromToday
        self.datePicker.maximumDate = twoYearsFromToday
        
        //timeLab
        timeLab = UILabel.init(frame: CGRectMake(0, self.datePicker.frame.origin.y - 40, self.frame.size.width, 40))
        timeLab.textAlignment = NSTextAlignment.Center
        timeLab.font = UIFont.systemFontOfSize(20)
        let dateString = datePicker.date.toString(format: DateFormat.Custom("yyyy-MM-dd HH:mm:ss"))
        timeLab.text = dateString
        timeLab.layer.borderColor = UIColor.lightGrayColor().CGColor
        timeLab.layer.borderWidth = 0.5
        
        self.addSubview(timeLab)
        
        // 取消
        cancelBtn = UIButton.init(type: UIButtonType.System)
        cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.datePicker.frame), self.frame.size.width / 2, 40)
        cancelBtn.setTitle("取消", forState: UIControlState.Normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cancelBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        cancelBtn.layer.borderWidth = 0.5
        self.addSubview(cancelBtn)
        
        // 确定
        sureBtn = UIButton.init(type: UIButtonType.System)
        sureBtn.frame = CGRectMake(frame.size.width / 2, CGRectGetMaxY(self.datePicker.frame), self.frame.size.width / 2, 40)
        sureBtn.setTitle("确定", forState: UIControlState.Normal)
        
        sureBtn.addTarget(self, action: #selector(sureBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sureBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
        sureBtn.layer.borderWidth = 0.5
        self.addSubview(sureBtn)
        
        // 背景
        backgroundView = UIView.init(frame: CGRectMake(0, self.frame.size.height - self.datePicker.frame.height - 80, self.frame.size.width, self.datePicker.frame.height + 80))
        backgroundView.backgroundColor = UIColor.whiteColor()
        self.insertSubview(backgroundView, atIndex: 0)
        
    }
    
    func datePickerDateChanged(datePicker: UIDatePicker) {
        
        let dateString = datePicker.date.toString(format: DateFormat.Custom("yyyy-MM-dd HH:mm:ss"))
        self.timeLab.text = dateString
        
        print("Selected date = \(dateString)")
    }
    
    func sureBtnAction(sender: AnyObject) {
        
        self.sureAction(parament: sender)
        self.removeFromSuperview()
        print("确定")
    }
    
    func cancelBtnAction(sender: AnyObject) {
        
        self.sureAction(parament: sender)
        self.removeFromSuperview()
        print("取消")
    }

}
