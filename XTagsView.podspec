Pod::Spec.new do |s|
s.name         = "XTagsView"    #存储库名称
s.version      = "0.0.1"      #版本号，与tag值一致
s.summary      = "热门标签栏的封装"  #简介
s.description  = "热门标签栏的封装"  #描述
s.homepage     = "https://github.com/lixiya1990/XYTagsView"      #项目主页，不是git地址
s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
s.author             = { "lixiya" => "lixiya@mana.com" }  #作者
s.platform     = :ios, "8.0"                  #支持的平台和版本号
s.source       = { :git => "https://github.com/lixiya1990/XYTagsView.git", :tag => "0.0.1" }         #存储库的git地址，以及tag值
s.source_files  =  "Classess/**/*.{h,m}" #需要托管的源代码路径
s.requires_arc = true #是否支持ARC

end
