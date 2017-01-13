//
//  GGWSParse.swift
//  SwiftTutorial
//
//  Created by Đăng Hoà on 8/12/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit

let IsLiveData:Bool = true

class GGWSParse: NSObject {
  /**
   * Custom Parse Header
   */
  
  class func parseDataSimple(dic:AnyObject, complete:(_ dicData: AnyObject?, _ errorParse: GGWSError?)-> Void)-> Void{
    complete(dic, nil)
  }
  
  class func parseDataAPIHaveDataReturn(statusCode: Int = 0, dic: AnyObject, complete:(_ dicData: AnyObject?, _ errorParse: GGWSError?)-> Void)-> Void {
    
    if IsLiveData == false {
      complete(dic, nil)
    }else{
      if dic.isKind(of: NSArray.classForCoder()) {
        complete(dic, nil)
      }else{
        
        if dic.isKind(of: NSDictionary.classForCoder()) {
          let dictionary = dic as! NSDictionary
          
          if statusCode / 100 != 2 {
            
            let errorDic = dictionary.dictionaryForKey("errors")
            
            if errorDic != nil && (errorDic?.allKeys.count)! > 0 {
              let new_error:GGWSError = GGWSError()
              new_error.error_id = statusCode
              new_error.error_msg = (errorDic?.stringForKey("detail"))!
              
              complete(nil, new_error)
              
            }else{
              
              let errorDic = dictionary.arrayForKey("errors")
              
              let new_error:GGWSError = GGWSError()
              new_error.error_id = statusCode
              new_error.error_msg = getStringWithErrorDic(error: errorDic)
              complete(nil, new_error)
            }
            
          }else{
            
            let array = dictionary.arrayForKey("data")
            let dic = dictionary.dictionaryForKey("data")
            let included = dictionary.object(forKey: "included")
            
            if array != nil {
              complete(dictionary, nil)
            }else if dic != nil {
              
              let mutable = NSMutableDictionary()
              let keys = dic?.allKeys
              for key in keys!{
                mutable.setValue(dic?.object(forKey: key), forKey: key as! String)
              }
              
              if included != nil {
                mutable.setValue(included, forKey:"included")
              }
              
              complete(mutable, nil)
              
            }else{
              complete(nil, nil)
            }
          }
          
        }else{
          complete(dic as? NSNumber, nil)
        }
      }
    }
  }
  
  class func getStringWithErrorDic(error: NSArray?)-> String{
    
    if (error?.count)! > 0 {
      for dic in error! {
        let detail = (dic as! NSDictionary).stringForKey("detail")
        
        if detail != "" {
          return detail
        }
      }
      return "Error!"
    }else{
      return "Error!"
    }
  }
  
  class func getPointerWithErrorDic(error: NSArray?)-> String{
    
    if (error?.count)! > 0 {
      for dic in error! {
        let source = (dic as! NSDictionary).dictionaryForKey("source")
        
        if source != nil {
          let pointer = source!.stringForKey("pointer")
          
          if pointer != "" {
            return pointer
          }
        }
      }
      return "Error!"
    } else {
      return "Error!"
    }
  }
  
}
