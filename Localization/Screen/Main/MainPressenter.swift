//
//  MainPressenter.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import Foundation

// MARK: - businessLogic

protocol MainBusinessLogic {
    var viewModel: MainViewModel? { get }
    func viewDidAppear()
}

// MARK: - class

final class MainPressenter {
    
    // MARK: - public properties
    
    var viewModel: MainViewModel?
    weak var view: MainDisplayLogic?
    
    // MARK: - initializers
    
    init() {
        self.viewModel = nil
    }
}

// MARK: - extension for MainBusinessLogic

extension MainPressenter: MainBusinessLogic {
    func viewDidAppear() {
        reloadViewModel()
        view?.reloadView()
    }
    
    private func reloadViewModel() {
        viewModel = .init(
            slug: LocalizableManager.shared.currentLanguage.rawValue,
            items: LocalizableManager.LanguageType.allCases.map { language in
                    .init(
                        slug: language.rawValue,
                        title: language.name,
                        onPressed: { [weak self] in
                            LocalizableManager.shared.currentLanguage = language
                            self?.reloadViewModel()
                            self?.view?.reloadView()
                        })
            })
    }
}

private extension LocalizableManager.LanguageType {
    var name: String {
        switch self {
        case .russian:
            return "Русский"
        case .english:
            return "English"
        case .turkish:
            return "Turkish"
        case .base:
            let currentLanguage = LocalizableManager.shared.currentLanguage.rawValue
            return R.string(preferredLanguages: [currentLanguage]).localizable.baseLocalized.callAsFunction()
        }
    }
}
