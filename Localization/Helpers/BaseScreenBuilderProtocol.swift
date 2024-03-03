//
//  BaseScreenBuilderProtocol.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import UIKit

protocol BaseScreenBuilderProtocol {
    associatedtype BuildType: UIViewController
    func build() -> BuildType
}
