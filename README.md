# datePicture
时间选择器 swift
XZDatePickerView 
新增可以选择时间模式
dateMode = UIDatePickerMode.DateAndTime
下面为选择类型
public enum UIDatePickerMode : Int {
    case Time // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    case Date // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    case DateAndTime // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    case CountDownTimer // Displays hour and minute (e.g. 1 | 53)
}
dateMode为自带枚举类型 UIDatePickerMode 详细格式看上面解释
