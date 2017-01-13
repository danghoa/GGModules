//
//  GGMCommon.swift
//  GGModuleLogin
//
//  Created by Đăng Hoà on 1/11/17.
//  Copyright © 2017 Green Global. All rights reserved.
//

import UIKit

class Common: NSObject {
  
  class func isValidEmail(_ testStr: String) -> Bool {
    
    let emailRegEx = "^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]{1}|[\\w-]{2,}))@"
      + "((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
      + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\."
      + "([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?"
      + "[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
      + "([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})$"
    
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    
    let result = emailTest.evaluate(with: testStr)
    
    return result
  }
  
  class func trimWhiteSpaceInsets(_ string: String) -> String {
    
    return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
  
  class func showAlert(_ message: String!, title: String, vc: UIViewController?) -> Void {
    
    let alertView: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction(title: "OK", style: .default) { _ in
      // Put here any code that you would like to execute when
      // the user taps that OK button (may be empty in your case if that's just
      // an informative alert)
    }
    alertView.addAction(action)
    
    vc?.present(alertView, animated: true, completion: nil)
  }
}
