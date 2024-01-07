//
//  AuthViewModel.swift
//  YourGamesData
//
//  Created by user253411 on 1/6/24.
//

import Foundation

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""

    @Published var authenticationError = false
    @Published var errorMessage = ""

    private var authModel = AuthModel()

    func authenticate() {
        authModel.authenticate(username: username, password: password)

        if !authModel.isAuthenticated {
            authenticationError = true
            errorMessage = "Invalid username or password. Please try again."
        }
    }
}
