//
//  L10n.swift
//  SocialNetwork
//
//  Created by mert alp on 3.11.2024.
//

import Foundation

final class L10n {
    
    // MARK: - Singleton
    static let shared = L10n()
    
    private init() {}

    // MARK: - Localization Keys
    enum LocalizationKeys {
       // Login View Model
        static let validationErrorTitle = "validation_error_title"
        static let invalidEmailMessage = "invalid_email_message"
        static let invalidPasswordMessage = "invalid_password_message"
        static let loginErrorTitle = "login_error_title"
        static let userFetchErrorTitle = "user_fetch_error_title"
        static let userFetchErrorMessage = "user_fetch_error_message"
        
        // Login View Controller
        static let loginTitle = "login_title"
        static let emailPlaceholder = "email_placeholder"
        static let passwordPlaceholder = "password_placeholder"
        static let forgotPasswordText = "forgot_password"
        static let orText = "or_text"
        static let noAccountText = "no_account"
        static let signUpText = "sign_up"
        static let continueButtonText = "continue_button_text"
        
        // Sign Up View Model
        static let signupValidationErrorMessage = "signup_validation_error_message"
        static let signupSelectProfileImage = "signup_select_profile_image"
        static let signupErrorTitle = "signup_error_title"
        static let signupSuccessTitle = "signup_success_title"
        static let signupSuccessMessage = "signup_success_message"
        static let signupFailure = "signup_failure"
        static let imageUploadErrorTitle = "image_upload_error_title"
        static let firestoreErrorTitle = "firestore_error_title"
        static let signupInvalidUsername = "signup_invalid_username"
        static let signupInvalidPassword = "signup_invalid_password"
        static let signupGeneralErrorMessage = "signup_general_error_message"
        
        // Sign Up View Controller
        static let signUpTitle = "sign_up_title"
        static let usernamePlaceholder = "username_placeholder"
        static let nicknamePlaceholder = "nickname_placeholder"
        static let aboutMePlaceholder = "about_me_placeholder"
        static let alreadyHaveAccountText = "already_have_account_text"
        static let loginText = "login_text"
        static let signUpButtonText = "sign_up_button_text"
    }

    // MARK: - Localized String Fetcher
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // MARK: - Localized Messages
    func validationErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.validationErrorTitle)
    }
    
    func invalidEmailMessage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.invalidEmailMessage)
    }
    
    func invalidPasswordMessage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.invalidPasswordMessage)
    }
    
    func loginErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.loginErrorTitle)
    }
    
    func userFetchErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.userFetchErrorTitle)
    }
    
    func userFetchErrorMessage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.userFetchErrorMessage)
    }
    
    func loginTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.loginTitle)
    }
    
    func emailPlaceholder() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.emailPlaceholder)
    }
    
    func passwordPlaceholder() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.passwordPlaceholder)
    }
    
    func forgotPasswordText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.forgotPasswordText)
    }
    
    func orText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.orText)
    }
    
    func noAccountText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.noAccountText)
    }
    
    func signUpText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signUpText)
    }
    
    func continueButtonText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.continueButtonText)
    }
    
    func signupValidationErrorMessage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signupValidationErrorMessage)
    }

    func signupSelectProfileImage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signupSelectProfileImage)
    }

    func signupErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signupErrorTitle)
    }
    
    func signupSuccessTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signupSuccessTitle)
    }

    func signupSuccessMessage() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signupSuccessMessage)
    }
    
    func imageUploadErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.imageUploadErrorTitle)
    }
    
    func firestoreErrorTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.firestoreErrorTitle)
    }
    
    func signUpTitle() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signUpTitle)
    }
    
    func usernamePlaceholder() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.usernamePlaceholder)
    }
    
    func nicknamePlaceholder() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.nicknamePlaceholder)
    }
    
    func aboutMePlaceholder() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.aboutMePlaceholder)
    }
    
    func alreadyHaveAccountText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.alreadyHaveAccountText)
    }
    
    func loginText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.loginText)
    }
    
    func signUpButtonText() -> String {
        return L10n.localizedString(forKey: LocalizationKeys.signUpButtonText)
    }
}
