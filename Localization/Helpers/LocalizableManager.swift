//
//  LocalizableManager.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import Foundation

// MARK: - class

final class LocalizableManager {
    
    // MARK: - enum
    
    enum LanguageType: String, CaseIterable {
        /// Русский
        case russian = "ru"
        /// Английский
        case english = "en"
        /// Турецкий
        case turkish = "tr"
        /// Базовый
        case base = "base"
    }
    
    // MARK: - public properties
    
    var currentLanguage: LanguageType {
        get {
            UserDefaults.language
        }
        
        set {
            UserDefaults.language = newValue
        }
    }
    
    // MARK: - public properties
    
    static let shared: LocalizableManager = {
        .init()
    }()
    
    // MARK: - initializers
    
    private init() {
    }
    
    // MARK: - public methods
    
    func config() {
        let languageType: LanguageType = UserDefaults.language
        UserDefaults.language = languageType
    }
}

// MARK: - extension for UserDefaults

private extension UserDefaults {
    private static var suiteName: String { "LocalizableManager" }
    private static var customLanguageKey: String { "customLanguage" }
    private static var languageManager: UserDefaults? {
        .init(suiteName: suiteName)
    }
    
    static func resetLanguageManager() {
        let userDefaults = UserDefaults(suiteName: suiteName)
        userDefaults?.removePersistentDomain(forName: suiteName)
    }
    
    static var language: LocalizableManager.LanguageType {
        get {
            if let customLanguage = languageManager?.string(forKey: customLanguageKey),
               let type = LocalizableManager.LanguageType(rawValue: customLanguage) {
                return type
            } else {
                if let appleLanguages = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>,
                   let customLanguage = appleLanguages.compactMap({ LocalizableManager.LanguageType(rawValue: $0) }).first {
                       return customLanguage
                   } else {
                       return .base
                   }
            }
        }
        
        set {
            languageManager?.set(newValue.rawValue, forKey: customLanguageKey)
            UserDefaults.standard.set([newValue.rawValue], forKey: "AppleLanguages")
        }
    }
}

extension Bundle {
    static var localized: Bundle {
        let selectedLanguage = LocalizableManager.shared.currentLanguage
        if let path = Bundle.main.path(forResource: selectedLanguage.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        } else {
            return .init()
        }
    }
}
