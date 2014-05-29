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
  s.source_files = 'FFCalendar/FFCalendars/*.{h,m}'
  s.screenshot   = "https://raw.githubusercontent.com/fggeraissate/FFCalendar/master/FFCalendar/FFCalendars/Util/Images/YearlyCalendar.png"
  s.requires_arc = true
end
