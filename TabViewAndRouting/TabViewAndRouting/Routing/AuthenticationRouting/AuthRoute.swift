//
//  AuthRoute.swift
//  TabViewAndRouting
//
//  Created by rajat.pandya on 15/04/26.
//

import Foundation

/// Routes available in the authentication flow
enum AuthRoute: Hashable {
    case login
    case signup
    case forgotPassword
    case resetPassword
    case resetPasswordConfirmation
}

enum AuthSheet: Identifiable {
    case resetPassword
    case termsAndConditions
    /// add more as needed
    var id: String { String(describing: self) }
}
