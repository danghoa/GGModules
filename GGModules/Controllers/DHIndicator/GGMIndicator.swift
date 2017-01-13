//
//  GGMIndicator.swift
//  GGStructureSwift
//
//  Created by Đăng Hoà on 8/13/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class GGMIndicator: NSObject {
  
  static var viewHud = UIView (frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height
  ))
  
  static var viewBgr = UIView(frame: CGRect(x: (viewHud.frame.size.width - 70) / 2, y: (viewHud.frame.size.height - 70) / 2, width: 70, height: 70))
  
  //static var indicator =  UIActivityIndicatorView(frame: CGRect(x: viewBgr.frame.size.width/2 - 10, y: viewBgr.frame.size.height/2 - 10 , width: 20, height: 20))
  
  static var indicator = NVActivityIndicatorView(frame: CGRect(x: (viewBgr.frame.size.width - 50) / 2, y: (viewBgr.frame.size.height - 50) / 2, width: 50, height: 50), type: .ballRotateChase, color: UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1), padding: 0)
  
  deinit {
    
  }
  
  class func show(onView view: UIView?) -> Void {
    
    DispatchQueue.main.async(execute: {
      
      viewBgr.addSubview(indicator)
      viewHud.addSubview(viewBgr)
      
      viewHud.backgroundColor = UIColor.clear
      
      indicator.startAnimating()
      
      viewBgr.backgroundColor = UIColor.black
      viewBgr.alpha = 0.6;
      viewBgr.layer.cornerRadius = 6
      
      view?.addSubview(viewHud)
    })
  }
  
  class func hide() -> Void {
    DispatchQueue.main.async(execute: {
      indicator.removeFromSuperview()
      viewBgr.removeFromSuperview()
      viewHud.removeFromSuperview()
    })
  }
  
}

class DHActiIndicator: UIView {
  
  // MARK: - Variables
  lazy fileprivate var animationLayer: CALayer = {
    return CALayer()
  }()
  
  var isAnimating: Bool = false
  var hidesWhenStopped: Bool = true
  
  var viewBG: UIView? = nil
  
  // MARK: - Init
  deinit {
    print(self.classForCoder)
    print("deinit")
  }
  
  init() {
    let image: UIImage = UIImage(named: "dh_loading")!
    
    let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
    
    self.viewBG = UIView(frame: frame)
    
    super.init(frame: frame)
    
    animationLayer.frame = frame
    animationLayer.contents = image.cgImage
    animationLayer.masksToBounds = true
    
    self.viewBG!.backgroundColor = UIColor.white
    self.viewBG!.layer.cornerRadius = 6.0
    self.viewBG!.layer.masksToBounds = true
    self.viewBG!.alpha = 0.25
    self.addSubview(viewBG!)
    self.layer.addSublayer(animationLayer)
    
    addRotation(forLayer: animationLayer)
    pause(animationLayer)
    self.isHidden = true
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Func
  func addRotation(forLayer layer: CALayer) {
    let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    rotation.duration = 0.9
    rotation.isRemovedOnCompletion = false
    rotation.repeatCount = HUGE
    rotation.fillMode = kCAFillModeForwards
    rotation.fromValue = NSNumber(value: 0.0 as Float)
    rotation.toValue = NSNumber(value: 3.14 * 2.0 as Float)
    
    layer.add(rotation, forKey: "rotate")
  }
  
  func pause(_ layer: CALayer) {
    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    
    layer.speed = 0.0
    layer.timeOffset = pausedTime
    
    isAnimating = false
  }
  
  func resume(_ layer: CALayer) {
    let pausedTime: CFTimeInterval = layer.timeOffset
    
    layer.speed = 1.0
    layer.timeOffset = 0.0
    layer.beginTime = 0.0
    
    let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    layer.beginTime = timeSincePause
    
    isAnimating = true
  }
  
  func startAnimating () {
    DispatchQueue.main.async(execute: {
      
      
      if self.isAnimating {
        return
      }
      
      if self.hidesWhenStopped {
        self.isHidden = false
      }
      self.resume(self.animationLayer)
    })
  }
  
  func stopAnimating () {
    DispatchQueue.main.async(execute: {
      
      if self.hidesWhenStopped {
        self.isHidden = true
      }
      self.pause(self.animationLayer)
    })
  }
}

