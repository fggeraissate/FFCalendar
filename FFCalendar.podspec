Pod::Spec.new do |s|
  s.name         = "FFCalendar"
  s.version      = "0.0.1"
  s.summary      = "Yearly, Monthly, Weekly and Daily Calendars for iOS."
  s.homepage     = "https://github.com/fggeraissate/FFCalendar"
  s.license      = "MIT"
  s.authors      = { "Fernanda G. Geraissate" => "fggeraissate@gmail.com" }
  s.source       = { :git => "https://github.com/fggeraissate/FFCalendar.git", :commit => '1e9d472e23374cf89edaeff409df1796ceb1faf8'}
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '7.0'
  s.source_files = 'FFCalendar/FFCalendars/FFCalendar.h'
  s.public_header_files = 'FFCalendar/FFCalendars/*.h'
  s.screenshot   = "https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/YearlyCalendar.png"
  s.requires_arc = true

    s.subspec 'Util' do |ss|
      ss.source_files = 'FFCalendar/FFCalendars/Util/**/*.{h,m}', 'FFCalendar/FFCalendars/Util/*.{h,m}'
      ss.public_header_files = 'FFCalendar/FFCalendars/Util/**/*.h', 'FFCalendar/FFCalendars/Util/*.h'
      ss.resource = 'FFCalendar/FFCalendars/Util/Images/*.png'
      ss.dependency 'SVProgressHUD'
    end

    s.subspec 'FFYearCalendarView' do |ss|
      ss.dependency 'FFCalendar/Util'
      ss.source_files = 'FFCalendar/FFCalendars/FFYearCalendarView/**/*.{h,m}'
    end

    s.subspec 'FFWeekCalendarView' do |ss|
     ss.dependency 'FFCalendar/Util'
     ss.source_files = 'FFCalendar/FFCalendars/FFWeekCalendarView/**/*.{h,m}'
    end

    s.subspec 'FFMonthCalendarView' do |ss|
     ss.dependency 'FFCalendar/Util'
     ss.source_files = 'FFCalendar/FFCalendars/FFMonthCalendarView/**/**/*.{h,m}'
    end

    s.subspec 'FFDayCalendarView' do |ss|
     ss.dependency 'FFCalendar/Util'
     ss.source_files = 'FFCalendar/FFCalendars/FFDayCalendarView/**/**/**/*.{h,m}'
    end		
end
