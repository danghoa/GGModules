//
//  GGWSIncredible.swift
//  GGModuleLogin
//
//  Created by Đăng Hoà on 1/12/17.
//  Copyright © 2017 Green Global. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class GGWSIncredible: NSObject {
  
  typealias successReturn = (_ value: Any?, _ error: GGWSError?)-> Void
  
  class func requestGETwithPath(path: String) {
    
    let urlString = path
    
    do {
      let request = try HTTP.GET(urlString)
      request.start({ (response) in
        if let error = response.error {
          print(error)
        } else {

          let j = JSON(data: response.data)
          
          let dicData = j.dictionaryObject
          
          print(j)
          
        }
      })
    } catch let error {
      print(error)
    }
  }
  
  class func requestPOSTwithPath(path: String, params: [String: Any], completed: @escaping successReturn) {
    let urlString = path
    
    do {
      let request = try HTTP.POST(urlString, parameters: params)
      request.start({ (response) in
        if let error = response.error {
          print(error)
        } else {
          let j = JSON(data: response.data)
          
          let dicData = j.dictionaryObject
          
          if dicData == nil || response.statusCode == nil {
            completed(nil, nil)
          } else {
            GGWSParse.parseDataAPIHaveDataReturn(statusCode: response.statusCode!, dic: dicData as AnyObject, complete: { (object, error) in
              completed(object, error)
            })
          }
        }
      })
    } catch let error {
      print(error)
      completed(nil, nil)
    }
  }

}
