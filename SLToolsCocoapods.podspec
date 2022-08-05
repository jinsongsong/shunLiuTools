
Pod::Spec.new do |spec|

  spec.name         = "SLToolsCocoapods"
  spec.version      = "1.1.0"
  spec.summary      = "Common function set"
  spec.description  = "Common function set；Add features and improve over time"
  spec.homepage     = "https://github.com/jinsongsong/shunLiuTools.git"
  spec.license      = "MIT"
  spec.author       = { "shun" => "646538938@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/jinsongsong/shunLiuTools.git", :tag => "v1.1.0" }
  spec.source_files = "Tools/*.{h,m}"
  spec.requires_arc = true
  spec.frameworks = "UIKit", "Foundation"

end
