//
//  LoginViewController.swift
//  Day12-LoginAnimation
//
//  Created by 田逸昕 on 2020/2/7.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Property
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usernameHorizontalConstraints: NSLayoutConstraint!   //username垂直约束
    @IBOutlet weak var passwordHorizontalConstraints: NSLayoutConstraint!   //password垂直约束
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.alpha = 0
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        usernameHorizontalConstraints.constant -= self.view.frame.width
        passwordHorizontalConstraints.constant -= self.view.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.1 , options: .curveEaseOut, animations: {
            self.usernameHorizontalConstraints.constant += self.view.frame.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.passwordHorizontalConstraints.constant += self.view.frame.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseOut, animations: {
            self.loginButton.alpha = 1
        }, completion: nil)
    }
    
    // MARK: Action
    /// 返回初始界面
    @IBAction func returnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 登录按钮点击事件
    @IBAction func loginAction(_ sender: Any) {
        let bounds = self.loginButton.bounds
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.loginButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginButton.isEnabled = false  //动画期间不可点击
        }, completion: { finished in self.loginButton.isEnabled = true })
    }
    
}

// MARK: Extension
extension LoginViewController: UITextFieldDelegate {
    /// return收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
