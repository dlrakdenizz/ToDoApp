//
//  ProfileViewModel.swift
//  ToDoApp
//
//  Created by Dilara Akdeniz on 22.05.2025.
//

import Foundation
struct ProfileViewModel{
    var user: User
    init(user: User) {
        self.user = user
    }
    var profileImageUrl: URL?{
        return URL(string: user.profileImageUrl)
    }
    var name: String?{
        return user.name
    }
    var username: String?{
        return user.username
    }
    var email: String?{
        return user.email
    }
}
