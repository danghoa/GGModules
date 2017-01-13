Pod::Spec.new do |spec|

# 1
spec.platform = :ios
spec.ios.deployment_target = '8.0'
spec.name = "GGModules"
spec.summary = "Green Global reusable resources"
spec.requires_arc = true

# 2
spec.version = "0.1.0"

# 3
spec.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
spec.author = { "Hoa Nguyen Dang" => "ndh7777777@gmail.com" }

# For example,
# spec.author = { "Hoa Nguyen Dang" => "ndh7777777@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
spec.homepage = "https://github.com/danghoa/GGModules"

# For example,
# spec.homepage = "https://github.com/danghoa/GGModules"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
spec.source = { :git => "https://github.com/danghoa/GGModules.git", :tag => "#{spec.version}"}

# For example,
# spec.source = { :git => "https://github.com/danghoa/GGModules.git", :tag => "#{spec.version}"}


# 7
spec.framework = "UIKit"
spec.dependency 'NVActivityIndicatorView'
spec.dependency 'SwiftHTTP'
spec.dependency 'SwiftyJSON'

# 8
spec.source_files = "GGModules/**/**/*.{swift}"
spec.source_files = "GGModules/**/**/**/*.{swift}"

# 9
spec.resources = "GGModules/**/**/**/*.{png,xib}"

# For example
# spec.resources = "GGModules/**/*.{png,xib}"

end
