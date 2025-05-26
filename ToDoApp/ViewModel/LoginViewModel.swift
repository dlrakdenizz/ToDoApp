//
//  LoginViewModel.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 5.05.2025.
//

import UIKit

struct LoginViewModel{
    var emailText: String?
    var passwordText: String?
    
    var status: Bool{
        return emailText?.isEmpty == false && passwordText?.isEmpty == false
    }
}
