//
//  LoginPageModel.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 21/10/22.
//

import Foundation
class LoginPageModel:ObservableObject{
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var registerUser:Bool = false
    @Published var showPassword:Bool = false
    @Published var re_enter_password:String = ""
    @Published var showEnterPassword:Bool = false
    func Login(){
        
    }
    func Register(){
        
    }
    func ForgetPassword(){
        
    }
}
