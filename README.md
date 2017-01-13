# Green Global Reusable Resources

[![Build Status](https://travis-ci.org/Alamofire/Alamofire.svg?branch=master)](https://github.com/danghoa/GGModules)
[![Platform](https://img.shields.io/cocoapods/p/Alamofire.svg?style=flat)](https://github.com/danghoa/GGModules)
> This is GGModules
### Requirements
* Swift3
* iOS 8.0+

### Installation

**GGModules** is available through CocoaPods. To install it, simply add the following line to your Podfile:

```swift
pod 'GGModules', :git => 'https://github.com/danghoa/GGModules.git'
```

### Author

Green Global, danghoanguyen, <ndh7777777@gmail.com> , Skype: @danghoanguyen

### License

GGModules is available under the MIT license. See the LICENSE file for more info.

### Usage

**How to present GGMSingIn**

```swift
    let signIn = GGMSignInVC(social: GGMSignInVC.Social.both, mainColor: UIColor.magenta, name: "Jonas Brothers")
    
    signIn.setting(backgroundColor: nil, backgroundImage: nil, imageFacebook: nil, imageGoogle: nil)
    
    signIn.settingAPI(path: [Your API])
    
    signIn.response { (type, detail, value) in
      
      if type == GGMSignInVC.Response.successfully {
        
      } else if type == GGMSignInVC.Response.failed {
        
      } else if type == GGMSignInVC.Response.forgot {
        
      } else if type == GGMSignInVC.Response.signUp {
        
      } else {
        
      }
      //
    }
    
    present(signIn, animated: true, completion: nil)
```
* Use setting function to change your hope styles.

### Example

![Photo](http://i.imgur.com/KxcFYZo.jpg)
