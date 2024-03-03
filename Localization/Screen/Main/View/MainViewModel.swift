//
//  MainViewModel.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import Foundation

struct MainViewModel {
    let slug: String
    let items: [Item]
    
    init(
        slug: String,
        items: [Item]
    ) {
        self.slug = slug
        self.items = items
    }
}

extension MainViewModel {
    struct Item {
        let slug: String
        let title: String
        let onPressed: () -> Void
    }
}
