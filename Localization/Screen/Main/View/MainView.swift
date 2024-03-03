//
//  MainView.swift
//  Localization
//
//  Created by ZverikRS on 03.03.2024.
//

import UIKit
import SnapKit

// MARK: - class

final class MainView: UIView {
    
    var model: MainViewModel? {
        didSet {
            let localizable = R.string(preferredLanguages: [model?.slug ?? ""]).localizable
            helloLabel.text = localizable.hello.callAsFunction()
            
            descriptionLabel.text = "\(localizable.dev.callAsFunction())\n\(localizable.name.callAsFunction())"
            firstLineLabel.text = localizable.descriptionFirstLine.callAsFunction()
            secondLineLabel.text = localizable.descriptionSecondLine.callAsFunction()
            
            itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            model?.items.forEach { item in
                let itemView: ItemView = .init()
                itemView.model = .init(item: item, isSelected: item.slug == model?.slug)
                itemsStackView.addArrangedSubview(itemView)
            }
        }
    }
    
    // MARK: - private properties
    
    private let itemsStackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let helloLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private let firstLineLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let secondLineLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - initializers
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        config()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    
    private func config() {
        addSubview(itemsStackView)
        itemsStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        addSubview(helloLabel)
        helloLabel.snp.makeConstraints {
            $0.top.equalTo(itemsStackView.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(firstLineLabel)
        firstLineLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(secondLineLabel)
        secondLineLabel.snp.makeConstraints {
            $0.top.equalTo(firstLineLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

// MARK: - extension for ItemView

private extension MainView {
    final class ItemView: UIView {
        struct ViewModel {
            let item: MainViewModel.Item?
            let isSelected: Bool
        }
        
        // MARK: - public properties
        
        var model: ViewModel? {
            didSet {
                let isSelected = (model?.isSelected ?? false)
                let color: UIColor = isSelected ? .green : .lightGray
                backgroundColor = isSelected ? color.withAlphaComponent(0.75) : color.withAlphaComponent(0.10)
                button.setTitle(model?.item?.title, for: .normal)
            }
        }
        
        // MARK: - private properties
        
        private lazy var button: HitTestButton = {
            let button = HitTestButton(hitTestBoundsInsetByd: 20)
            button.addTarget(self, action: #selector(onButtonTouchUpInside), for: .touchUpInside)
            return button
        }()
        
        // MARK: - initializers
        
        override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            config()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - private methods
        
        private func config() {
            layer.cornerRadius = 10
            backgroundColor = .lightGray
            addSubview(button)
            button.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(5)
                $0.centerX.equalToSuperview()
            }
        }
        
        @objc private func onButtonTouchUpInside(_ sender: UIButton) {
            model?.item?.onPressed()
        }
    }
}

// MARK: - extension for HitTestButton

private extension MainView.ItemView {
    final class HitTestButton: UIButton {
        
        // MARK: - private properties
        
        private let hitTestBoundsInsetByd: CGFloat
        override var buttonType: UIButton.ButtonType {
            .system
        }
        
        // MARK: - initializers
        
        init(hitTestBoundsInsetByd: CGFloat = 10) {
            self.hitTestBoundsInsetByd = hitTestBoundsInsetByd
            super.init(frame: .zero)
            self.setTitleColor(.blue, for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - life cycle
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let convertToSelfView = convert(point, to: self)
            let newBounds: CGRect = bounds.insetBy(dx: -hitTestBoundsInsetByd, dy: -hitTestBoundsInsetByd)
            if newBounds.contains(convertToSelfView) {
                return self
            } else {
                return super.hitTest(point, with: event)
            }
        }
    }
}
