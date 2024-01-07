//
//  Auth.swift
//  YourGamesData
//
//  Created by user253411 on 1/6/24.
//

import Foundation
import Foundation

class AuthModel: ObservableObject {
    @Published var isAuthenticated = false

    func authenticate(username: String, password: String) {
        // Validar credenciales (en este ejemplo, usuario: "user", contraseña: "user")
        if username == "user" && password == "user" {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
}
