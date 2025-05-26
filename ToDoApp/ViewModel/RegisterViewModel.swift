//
//  RegisterViewModel.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 13.05.2025.
//

import UIKit

struct RegisterViewModel{
    var emailText: String?
    var passwordText: String?
    var nameText: String?
    var usernameText: String?
    
    var status: Bool{
        return emailText?.isEmpty == false && passwordText?.isEmpty == false && nameText?.isEmpty == false && usernameText?.isEmpty == false
    }
}
