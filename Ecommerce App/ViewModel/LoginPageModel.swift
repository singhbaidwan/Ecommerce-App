//
//  LoginPageModel.swift
//  Ecommerce App
//
//  Created by Dalveer singh on 21/10/22.
//
import SwiftUI
class LoginPageModel:ObservableObject{
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var registerUser:Bool = false
    @Published var showPassword:Bool = false
    @Published var re_enter_password:String = ""
    @Published var showEnterPassword:Bool = false
    @AppStorage("log_status") var log_status : Bool = false
    func Login(){
        withAnimation {
            log_status = true
        }
    }
    func Register(){
        withAnimation {
            log_status = true
        }
    }
    func ForgetPassword(){
        
    }
}
