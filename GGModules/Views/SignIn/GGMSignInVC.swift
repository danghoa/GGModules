//
//  GGMSignInVC.swift
//  GGModuleLogin
//
//  Created by Đăng Hoà on 1/11/17.
//  Copyright © 2017 Green Global. All rights reserved.
//

import UIKit

public class GGMSignInVC: UIViewController {
  
  // MARK: - Enum
  public enum Social {
    case facebook
    case google
    case both
    case none
  }
  
  public enum Response {
    case successfully
    case failed
    case forgot
    case signUp
    case none
  }
  
  public typealias successReturn = (_ result: Response, _ detail: String, _ value: Any?)-> Void
  
  // MARK: - Outlets
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private var viewMain: UIView!
  @IBOutlet private weak var imvBG: UIImageView!
  @IBOutlet private weak var lblNameProject: UILabel!
  @IBOutlet private weak var lblLoginWithAccount: UILabel!
  @IBOutlet private weak var btnFacebook: UIButton!
  @IBOutlet private weak var btnGoogle: UIButton!
  @IBOutlet private weak var lblLoginWithYourAccount: UILabel!
  @IBOutlet private weak var viewEmail: UIView!
  @IBOutlet private weak var tfEmail: UITextField!
  @IBOutlet private weak var viewPassword: UIView!
  @IBOutlet private weak var tfPassword: UITextField!
  @IBOutlet private weak var viewLogin: UIView!
  @IBOutlet private weak var btnLogin: UIButton!
  @IBOutlet private weak var btnForgotPassword: UIButton!
  @IBOutlet private weak var lblDontHaveAccount: UILabel!
  @IBOutlet private weak var btnSignUp: UIButton!
  
  // MARK: - Constant
  @IBOutlet weak var consAlignCenterBtnFB: NSLayoutConstraint!
  @IBOutlet weak var consHeightBtnFB: NSLayoutConstraint!
  @IBOutlet weak var consWidthBtnFB: NSLayoutConstraint!
  
  @IBOutlet weak var consAlignCenterBtnGG: NSLayoutConstraint!
  @IBOutlet weak var consHeightBtnGG: NSLayoutConstraint!
  @IBOutlet weak var consWidthBtnGG: NSLayoutConstraint!
  
  @IBOutlet weak var consTopLblLoginYourAccount: NSLayoutConstraint!
  
  // MARK: - Variables
  private var typeSocial: Social = Social.none
  private var typeMaincolor: UIColor = UIColor(red: 22 / 255.0, green: 122 / 255.0, blue: 255 / 255.0, alpha: 1.0)
  private var typeName = ""
  private var typeBackgroundColor: UIColor? = nil
  private var typeBackgroundImage: UIImage? = nil
  private var typeImageFacebook: UIImage? = nil
  private var typeImageGoogle: UIImage? = nil
  private var isSetting: Bool = false
  
  private var typePath: String = ""
  
  private var keyboardHeight: CGFloat = 0.0
  
  private var response: successReturn?
  
  // MARK: - Life Circles
  override private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: "GGMSignInVC", bundle: nibBundleOrNil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  convenience public init(social: Social, mainColor: UIColor, name: String) {
    let bundle = Bundle(for: GGMSignInVC.self)
    self.init(nibName: "GGMSignInVC", bundle: bundle)
    
    typeSocial = social
    typeMaincolor = mainColor
    typeName = name
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override public func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    GGMIndicator.hide()
  }
  
  override public func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    viewMain.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight > 667 ? screenHeight : 667)
    tableView.tableHeaderView = viewMain
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    configureViewBegin()
    configureWithSetting()
  }
  
  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Publics
  public func setting(backgroundColor: UIColor?, backgroundImage: UIImage?, imageFacebook: UIImage?, imageGoogle: UIImage?) {
    
    isSetting = true
    
    typeBackgroundColor = backgroundColor
    typeBackgroundImage = backgroundImage
    typeImageFacebook = imageFacebook
    typeImageGoogle = imageGoogle
  }
  
  public func settingAPI(path: String) {
    typePath = path
  }
  
  public func response(res: @escaping successReturn) {
    response = res
  }
  
  // MARK: - Configures
  private func configureViewBegin() {
    viewLogin.layer.cornerRadius = 3.0
    viewLogin.layer.shadowColor = typeMaincolor.withAlphaComponent(0.57).cgColor
    viewLogin.layer.shadowOpacity = 1
    viewLogin.layer.shadowOffset = CGSize.zero
    viewLogin.layer.shadowRadius = 10
    
    viewEmail.layer.borderColor = UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1).cgColor
    viewEmail.layer.borderWidth = 1.0
    viewPassword.layer.borderColor = UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1).cgColor
    viewPassword.layer.borderWidth = 1.0
    
    tfEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)])
    tfPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1), NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)])
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
  }
  
  private func configureWithSetting() {
    lblNameProject.textColor = typeMaincolor
    lblNameProject.text = typeName
    
    viewLogin.backgroundColor = typeMaincolor
    btnForgotPassword.setTitleColor(typeMaincolor.withAlphaComponent(0.78), for: UIControlState.normal)
    
    lblDontHaveAccount.textColor = typeMaincolor
    btnSignUp.setTitleColor(typeMaincolor, for: UIControlState.normal)
    
    settingStyle()
    
    settingSocial(social: typeSocial)
  }
  
  private func settingStyle() {
    
    if isSetting == true {
      if typeBackgroundColor != nil {
        
        view.backgroundColor = typeBackgroundColor
        viewMain.backgroundColor = typeBackgroundColor
        
        imvBG.image = nil
        
      } else {
        
        if typeBackgroundImage != nil {
          imvBG.image = typeBackgroundImage
        }
      }
      
      if typeImageFacebook != nil {
        btnFacebook.setImage(typeImageFacebook, for: UIControlState.normal)
      }
      
      if typeImageGoogle != nil {
        btnGoogle.setImage(typeImageGoogle, for: UIControlState.normal)
      }
    }
  }
  
  private func settingSocial(social: Social) {
    
    if social == Social.facebook {
      btnGoogle.alpha = 0.0
      consAlignCenterBtnFB.constant = 0
      consHeightBtnFB.constant = 55
      consWidthBtnFB.constant = screenWidth - 40*2
      
      let image = UIImage(named: "ic_fb_large", in: getBundle(), compatibleWith: nil)
      
      btnFacebook.setImage(image, for: UIControlState.normal)
      
    } else if social == Social.google {
      btnFacebook.alpha = 0.0
      consAlignCenterBtnGG.constant = 0
      consHeightBtnGG.constant = 55
      consWidthBtnGG.constant = screenWidth - 40*2
      
      let image = UIImage(named: "ic_gg_large", in: getBundle(), compatibleWith: nil)
      
      btnGoogle.setImage(image, for: UIControlState.normal)
    } else if social == Social.both {
      btnGoogle.alpha = 1.0
      consAlignCenterBtnFB.constant = -76.5
      consHeightBtnFB.constant = 48
      consWidthBtnFB.constant = 142
      
      btnFacebook.alpha = 1.0
      consAlignCenterBtnGG.constant = 77.5
      consHeightBtnGG.constant = 48
      consWidthBtnGG.constant = 142
    } else {
      lblLoginWithAccount.alpha = 0.0
      btnGoogle.alpha = 0.0
      btnFacebook.alpha = 0.0
      
      consTopLblLoginYourAccount.constant = -75
    }
  }
  
  private func validate() -> Bool {
    if Common.trimWhiteSpaceInsets(tfEmail.text!) == "" {
      showAlert(mess: "Please enter your email", title: typeName, vc: self)
      return false
    } else if !Common.isValidEmail(tfEmail.text!) {
      showAlert(mess: "Email address is invalid", title: typeName, vc: self)
      return false
    } else if Common.trimWhiteSpaceInsets(tfPassword.text!) == "" {
      showAlert(mess: "Please enter your password", title: typeName, vc: self)
      return false
    } else if Common.trimWhiteSpaceInsets(tfPassword.text!).characters.count < 6 {
      showAlert(mess: "Password must be 6 characters or more", title: typeName, vc: self)
      return false
    } else if Common.trimWhiteSpaceInsets(typePath).characters.count < 6 {
      showAlert(mess: "Please setting your API path", title: typeName, vc: self)
      return false
    } else {
      return true
    }
  }
  
  private func getBundle() -> Bundle {
    let bundle = Bundle(for: GGMSignInVC.self)
    return bundle
  }
  
  // MARK: - Keyboard
  func keyboardWasShown(_ notification: Notification) {
    if (((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
      let contentInsets = UIEdgeInsets(top: 0, left: 0.0, bottom: keyboardHeight, right: 0.0)
      tableView.contentInset = contentInsets
    }
  }
  
  func keyboardWasHide(_ notification: Notification) {
    let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    tableView.contentInset = contentInsets
  }
  
  func keyboardChanged(_ notification: Notification) {
    let sizeKeyboard = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
    
    keyboardHeight = (sizeKeyboard.height > sizeKeyboard.width ? sizeKeyboard.width : sizeKeyboard.height)
  }
  
  
  // MARK: - Actions
  @IBAction private func tapToHideKeyboard(_ sender: Any) {
    view.endEditing(true)
  }
  
  @IBAction private func tapToLogin(_ sender: Any) {
    if validate() {
      view.endEditing(true)
      
      let params = [
        
        "email": Common.trimWhiteSpaceInsets(tfEmail.text!),
        "password": Common.trimWhiteSpaceInsets(tfPassword.text!),
        ]
      GGMIndicator.show(onView: view)
      GGWSIncredible.requestPOSTwithPath(path: typePath, params: params, completed: {[weak self] (object, error) in
        GGMIndicator.hide()
        if object != nil && error == nil {
          self?.response?(Response.successfully, "Login successfully", object)
        } else {
          self?.response?(Response.failed, "", nil)
        }
      })
    }
  }
  
  @IBAction private func tapToForgot(_ sender: Any) {
    view.endEditing(true)
    response?(Response.forgot, "Tap To Forgot", nil)
  }
  
  @IBAction private func tapToSignUp(_ sender: Any) {
    view.endEditing(true)
    response?(Response.signUp, "Tap To Sign Up", nil)
  }
  
}
