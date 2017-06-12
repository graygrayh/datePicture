//
//  XZDatePickerView.swift
//  PeopleLight
//
//  Created by 典爆mac on 2017/4/10.
//  Copyright © 2017年 smartit. All rights reserved.
//

import UIKit

class XZDatePickerView: UIView {
    
    var datePicker : UIDatePicker!
    
    /// 时间模式
    var dateMode = UIDatePickerMode.DateAndTime
    
    /// 取消按钮
    var cancelBtn : UIButton!
    
    /// 确定按钮
    var sureBtn : UIButton!
    
    /// 时间控件
    var timeLab : UILabel!
    
    /// 背景视图
    var backgroundView : UIView!
    
    /// 当前时间按钮
    var currentDate : NSDate?

    /// 最小时间点
    var minimumDate : NSDate?
    
    /// 最大时间点
    var maximumDate : NSDate?
    
    /// 确定回调事件
    var sureAction:(parament:AnyObject,date:NSDate)->() = ({_ in
        
    })
    /// 取消回调事件
    var cancelAction:(parament:AnyObject,date:NSDate)->() = ({_ in
        
    })

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        self.datePicker = UIDatePicker()
        if currentDate != nil {
            datePicker.date = currentDate!
        }
        datePicker.datePickerMode = dateMode
        self.datePicker.frame.size.height =  self.datePicker.frame.size.height - 45
        self.datePicker.center = CGPointMake(self.center.x, self.frame.size.height - self.datePicker.frame.size.height / 2 - 40)
        self.addSubview(self.datePicker)
        
        self.datePicker.addTarget(self,
                                  action: #selector(self.datePickerDateChanged(_:)),
                                  forControlEvents: .ValueChanged)
        
        
        self.datePicker.minimumDate = minimumDate
        self.datePicker.maximumDate = maximumDate
        
        //timeLab
        timeLab = UILabel.init(frame: CGRectMake(0, self.datePicker.frame.origin.y - 40, self.frame.size.width, 40))
        timeLab.textAlignment = NSTextAlignment.Center
        timeLab.font = UIFont.systemFontOfSize(20)
        
        var timefor = "yyyy-MM-dd HH:mm:ss"
        switch self.dateMode {
        case .CountDownTimer:
            timefor = "hh:mm"
            break
        case .DateAndTime:
            timefor = "yyyy-MM-dd HH:mm:ss"
            break
        case .Date:
            timefor = "yyyy-MM-dd"
            break
        case .Time:
            timefor = "HH:mm"
            break
        }
        
        let dateString = datePicker.date.toString(format: DateFormat.Custom(timefor))
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
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.backgroundTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func backgroundTap(sender:AnyObject) {
        self.cancelAction(parament: sender,date: datePicker.date)
        self.removeFromSuperview()
        print("取消")
    }
    
    func datePickerDateChanged(datePicker: UIDatePicker) {
        
        var timefor = "yyyy-MM-dd HH:mm:ss"
        switch self.dateMode {
        case .CountDownTimer:
            timefor = "hh:mm"
            break
        case .DateAndTime:
            timefor = "yyyy-MM-dd HH:mm:ss"
            break
        case .Date:
            timefor = "yyyy-MM-dd"
            break
        case .Time:
            timefor = "HH:mm"
            break
        }
        let dateString = datePicker.date.toString(format: DateFormat.Custom(timefor))
        self.timeLab.text = dateString
        
        print("Selected date = \(dateString)")
    }
    
    func sureBtnAction(sender: AnyObject) {
        
        self.sureAction(parament: sender,date: datePicker.date)
        self.removeFromSuperview()
        print("确定")
    }
    
    func cancelBtnAction(sender: AnyObject) {
        
        self.cancelAction(parament: sender,date: datePicker.date)
        self.removeFromSuperview()
        print("取消")
    }

}
