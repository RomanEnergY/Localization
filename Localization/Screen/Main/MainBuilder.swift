//
//  MainScreenBuilder.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import Foundation

final class MainScreenBuilder: BaseScreenBuilderProtocol {
    func build() -> MainViewController {
        let pressenter: MainPressenter = .init()
        let vc: MainViewController = .init(presenter: pressenter)
        pressenter.view = vc
        return vc
    }
}
