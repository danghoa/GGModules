//
//  GGExtensionDictionary+Array.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 9/15/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import Foundation

public extension NSMutableArray {

  func kRemoveObjectAtIndex(_ index: Int) -> Void {
    if self.count > 0 {

      if index < self.count {
        self.removeObject(at: index)
      } else {
        print("Extension: Don't remove object")
      }

    } else {
      print("Extension: Don't remove object")
    }
  }

  func kReplaceObjectAtIndex(_ index: Int, withObject object: AnyObject?) -> Void {
    if self.count > 0 {

      if index < self.count && object != nil {
        self.replaceObject(at: index, with: object!)
      } else {
        print("Extension: Don't replace object")
      }

    } else {
      print("Extension: Don't replace object")
    }
  }

  func kInsertObject(_ object: AnyObject?, atIndex index: Int) -> Void {

    if self.count > 0 {

      if index < self.count && object != nil {
        self.insert(object!, at: index)
      } else {
        print("Extension: Don't insert object")
      }
    } else {
      print("Extension: Don't insert object")
    }
  }
}

public extension NSArray {

  func isEmpty() -> Bool {
    if self.count > 0 {
      return false
    } else {
      return true
    }
  }

  func kObjectAtIndex(_ index: Int) -> AnyObject? {

    if self.isEmpty() == true {
      return nil
    } else {
      return self.object(at: index) as AnyObject?
    }
  }
}


public extension NSDictionary {

  func checkNumeric(_ s: String) -> Bool {

    let sc: Scanner = Scanner(string: s)

    if sc.scanFloat(nil) {
      return sc.isAtEnd
    } else {
      return false
    }
  }

  func parseObjectForKey(_ key: String) -> AnyObject {
    return self.object(forKey: key)! as AnyObject
  }

  func dictionaryForKey(_ key: String) -> NSDictionary? {

    if self.object(forKey: key) != nil {
      return self.object(forKey: key) as? NSDictionary
    } else {
      return nil
    }
  }

  func arrayForKey(_ key: String) -> NSArray? {
    if (self.object(forKey: key) as AnyObject).isKind(of: NSArray.classForCoder()) == true {
      return self.object(forKey: key) as? NSArray
    } else {
      return nil
    }
  }

  func stringForKey(_ key: String) -> String {

    if self.object(forKey: key) != nil {

      if (self.object(forKey: key) as AnyObject).isKind(of: NSString.classForCoder()) == true {
        let temp: String = self.object(forKey: key) as! String

        if temp == "null" || temp == "<null>" || temp == "(null)" || temp == "" || temp.isEmpty {
          return ""
        } else {
          return NSDictionary.stringByStrippingHTML(temp)
        }
      } else {
        return ""
      }
    } else {
      return ""
    }

  }

  func intForKey(_ key: String) -> Int {

    let temp = self.object(forKey: key)

    if temp == nil {
      return 0
    } else {
      if (self.object(forKey: key)! as AnyObject).isKind(of: NSNumber.classForCoder()) == true {

        let num: NSNumber = self.object(forKey: key) as! NSNumber
        return num.intValue
      } else {
        return 0
      }
    }
  }

  func floatForKey(_ key: String) -> Float {

    let temp = self.object(forKey: key)

    if temp == nil {
      return 0.0
    } else {
      if (self.object(forKey: key)! as AnyObject).isKind(of: NSNumber.classForCoder()) == true {

        let num: NSNumber = self.object( forKey: key) as! NSNumber
        let temp: String = String(format: "%f", num.floatValue)
        if temp == "null" || temp == "<null>" || temp == "(null)" || temp == "" || temp.isEmpty {
          return 0.0
        } else {
          return NSString(string: temp).floatValue
        }
      } else if (self.object(forKey: key)! as AnyObject).isKind(of: NSString.classForCoder()) {
        let temp: String = self.object(forKey: key) as! String
        if temp == "null" || temp == "<null>" || temp == "(null)" || temp == "" || temp.isEmpty {
          return 0.0
        } else {
          return NSString(string: temp).floatValue
        }
      } else {
        return 0.0
      }
    }
  }

  func doubleForKey(_ key: String) -> Double {

    let temp = self.object(forKey: key)

    if temp == nil {
      return 0.0000000
    } else {
      if (self.object(forKey: key)! as AnyObject).isKind(of: NSNumber.classForCoder()) == true {

        let num: NSNumber = self.object( forKey: key) as! NSNumber
        let temp: String = String(format: "%f", num.floatValue)
        if temp == "null" || temp == "<null>" || temp == "(null)" || temp == "" || temp.isEmpty {
          return 0.0000000
        } else {
          return NSString(string: temp).doubleValue
        }
      } else if (self.object(forKey: key)! as AnyObject).isKind(of: NSString.classForCoder()) {
        let temp: String = self.object(forKey: key) as! String
        if temp == "null" || temp == "<null>" || temp == "(null)" || temp == "" || temp.isEmpty {
          return 0.0000000
        } else {
          return NSString(string: temp).doubleValue
        }
      } else {
        return 0.0000000
      }
    }
  }

  fileprivate class func stringByStrippingHTML(_ string: String) -> String {
    var r: NSRange
    var s: NSString = NSString(string: string)
    r = s.range(of: "<[^>]+>", options: NSString.CompareOptions.regularExpression)
    while r.location != NSNotFound {
      s = s.replacingCharacters(in: r, with: "") as NSString
      r = s.range(of: "<[^>]+>", options: NSString.CompareOptions.regularExpression)
    }
    return s as String;
  }

}
