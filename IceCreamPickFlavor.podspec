Pod::Spec.new do |s|

    # You first specify basic information about the pod. Swift based CocoaPods must have a minimum deployment target of 8.0 or higher. If you specify a lower version, the pod won’t install correctly.
    s.platform = :ios
    s.ios.deployment_target = '8.0'
    s.name = "IceCreamPickFlavor"
    s.summary = "IceCreamPickFlavor lets a user select an ice cream flavor."
    s.requires_arc = true

    # 2A Podspec is essentially a snapshot in time of your CocoaPod as denoted by a version number. When you update a pod, you will also need to update the Podspec’s Semantic Versioning
    s.version = "0.1.0"

    # All pods must specify a license. If you don’t, CocoaPods will present a warning when you try to install the pod, and you won’t be able to upload it to CocoaPods trunk – the master specs repo
    s.license = { :type => "MIT", :file => "LICENSE" }

    # specify information about yourself, the pod author
    s.authors = { "kevin m thornton" => "kevinmthornton@gmail.com" }

    # 5 - Replace this URL with your own Github page's URL (from the address bar)
    s.homepage = "https://github.com/kevinmthornton/IceCreamPickFlavor"

    # 6 - Git URL from "Quick Setup"
    s.source = { :git => "https://github.com/kevinmthornton/IceCreamPickFlavor.git", :tag => "0.1.0"}

    # specify the framework and any pod dependencies
    s.framework = "UIKit"
    s.dependency 'Alamofire', '~> 2.0'
    s.dependency 'MBProgressHUD', '~> 0.9.0'

    # specify the public source files based on file extensions; in this case, you specify .swift as the extension
    s.source_files = "IceCreamPickFlavor/**/*.{swift}"

    # specify the resources based on their file extensions
    s.resources = "IceCreamPickFlavor/**/*.{png,jpeg,jpg,storyboard,xib}"
end