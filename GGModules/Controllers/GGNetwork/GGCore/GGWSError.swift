//
//  GGWSError.swift
//  SwiftTutorial
//
//  Created by Đăng Hoà on 8/12/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit

let GGWSErrorNotification: String = "GGWSErrorNotification"

class GGWSError: NSObject {
  
  static var _error: GGWSError!
  
  /**
   * Property of class
   * @property error_id : id of error
   * @property error_msg : message of error
   */
  
  var error_id: Int = 0
  var error_msg: String = ""
  
  /**
   * Function share instance error
   */
  
  class func errorWithMessage(_ msg: String) -> GGWSError {
    
    if _error == nil {
      _error = GGWSError()
      _error.error_id = 69
      _error.error_msg = msg
      
      return _error
    } else {
      _error.error_id = 69
      _error.error_msg = msg
      return _error;
    }
  }
  
}
