//
//  CustomButton.swift
//  StopSmoke
//
//  Created by Марат Саляхетдинов on 26.03.2025.
//

import UIKit

enum ButtonType {
    case filled
    case bordered
    case clear
}

class CommonButton: UIButton {
    
    func enable() {
        isUserInteractionEnabled = true
    }
    
    func disable() {
        isUserInteractionEnabled = false
    }
}

final class CustomButton: CommonButton {
    
    // MARK: - Private properties
    
    private var height: Int {
        if case .dashBordered = style {
            return 56
        } else {
            return 44
        }
    }
    private var cornerRadius: CGFloat {
        if case .dashBordered = style {
            return 16
        } else {
            return 22
        }
    }
    private let spacing = 8.0
    private let borderWidth = 1.0
    
    private var settings: ButtonSettings
    
    private var style: ButtonStyle { settings.style }
    
    private var iconPlacement: ButtonIconPlacement? {
        if case .yes( _, let placement) = settings.icon {
            return placement
        } else {
            return nil
        }
    }
    
    private var iconName: String? {
        if case .yes(let iconName, _) = settings.icon {
            return iconName
        } else {
            return nil
        }
    }
    
    private var imageSize: CGSize = .zero
    
    // MARK: - Init
    
    init(settings: ButtonSettings) {
        self.settings = settings
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerTextAndImage()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        if case .dashBordered = style {
            addDashedBorder(color: style.titleColor.cgColor, cornerRadius: cornerRadius, lineWidth: 2)
        }
    }
    
    // MARK: - Public Methods
    
    func setLeftImage(_ iconName: String) {
        settings.icon = .yes(iconName: iconName, placement: .left)
        showsTouchWhenHighlighted = true
        setIcon()
    }
    
    func setRightImage(_ iconName: String) {
        settings.icon = .yes(iconName: iconName, placement: .right)
        showsTouchWhenHighlighted = true
        setIcon()
    }
    
    func setTitle(_ title: String) {
        setTitle(title.uppercased(), for: .normal)
    }
    
    override func disable() {
        super.disable()
//        setupAsDisabled()
        alpha = 0.5
    }
    
    override func enable() {
        super.enable()
//        setupAsEnabled()
        alpha = 1
    }
}

// MARK: - Private Methods

private extension CustomButton {
    
    //MARK: Required setups
    
    func setup() {
        setupBackground()
        setupTitle()
        setHeight()
        
        if case .bordered = style {
            setupBorder()
        }
        
        if case .yes(_, _) = settings.icon {
            setIcon()
        }
        
        if case .intrinsic = settings.widthType {
            setContentInsets()
        }
    }
    
    func setupBackground() {
        backgroundColor = style.backColor
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    func setupTitle() {
        titleLabel?.font = SmokeFont.button.get
        setTitleColor(style.titleColor, for: .normal)
        setTitleColor(style.titleColor.withAlphaComponent(0.4), for: .highlighted)
        setTitle(settings.title.localized.uppercased(), for: .normal)
    }
    
    func setHeight() {
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
    //MARK: Optional setups
    
    func setIcon() {
        guard let iconName, let image = UIImage(named: iconName)?.withTintColor(style.titleColor) else { return }
        self.imageSize = image.size
        self.setImage(image, for: .normal)
        self.centerTextAndImage()
    }
    
    func setupBorder() {
        layer.borderWidth = borderWidth
        layer.borderColor = style.titleColor.cgColor
    }
    
    func setContentInsets() {
        contentEdgeInsets = settings.contentInset
    }
    
    //MARK: Utilities
    
    func centerTextAndImage() {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        switch iconPlacement {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
            contentEdgeInsets = settings.contentInset
        case .right:
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.bounds.size.width - (imageSize.width+spacing*2), bottom: 0, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width+spacing*2), bottom: 0, right: 0)
        case .middle:
            break
        default: break
        }
    }
    
    func setupAsDisabled() {
        backgroundColor = style.disableBackColor
    }
    
    func setupAsEnabled() {
        backgroundColor = style.backColor
    }
}

import UIKit

struct ButtonSettings {
    let style: ButtonStyle
    var icon: ButtonIcon
    let title: String
    let widthType: ButtonWidthType
    let contentInset: UIEdgeInsets
    
    init(style: ButtonStyle, icon: ButtonIcon = .no, title: String, widthType: ButtonWidthType = .external, contentInset: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)) {
        self.style = style
        self.icon = icon
        self.title = title
        self.widthType = widthType
        self.contentInset = contentInset
    }
}

enum ButtonStyle {
    case filled(color: UIColor = .black, disableColor: UIColor = .gray, textColor: UIColor = .white)
    case bordered
    case dashBordered
    case clear(textColor: UIColor = .black)
    
    var backColor: UIColor {
        switch self {
        case .filled(let color, _, _):
            return color
        case .bordered, .dashBordered:
            return .background
        case .clear( _):
            return .clear
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .filled( _, _, let textColor):
            return textColor
        case .bordered, .dashBordered:
            return .black
        case .clear(let textColor):
            return textColor
        }
    }
    
    var disableBackColor: UIColor {
        switch self {
        case .filled( _, let color, _):
            return color
        case .bordered, .dashBordered:
            return .gray
        case .clear( _):
            return .clear
        }
    }
}

enum ButtonIcon {
    case no
    case yes(iconName: String, placement: ButtonIconPlacement)
}

enum ButtonIconPlacement {
    case left
    case right
    case middle
}

enum ButtonWidthType {
    case intrinsic
    case external
}
