import UIKit

class ColorPaletteView: UIControl {
    weak var delegate: ChangeColorProtocol?

    private var stackView = UIStackView()
    
    var chosenColor:UIColor = .systemGray6
    var redControl = ColorSliderView(colorName: "Red    ", value: 0)
    var greenControl = ColorSliderView(colorName: "Green", value: 0)
    var blueControl = ColorSliderView(colorName: "Blue   ", value: 0)
    
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        redControl.value = Float(chosenColor.rgba.red)
        greenControl.value = Float(chosenColor.rgba.green)
        blueControl.value = Float(chosenColor.rgba.blue)
        
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        
        stackView = UIStackView(arrangedSubviews: [redControl, greenControl, blueControl])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        
        [redControl, greenControl, blueControl].forEach {
            $0.addTarget(self, action: #selector(sliderMoved(slider:)), for: .touchDragInside)
        }
        
        addSubview(stackView)
        stackView.pinBottom(to: self, 12)
        stackView.pinLeft(to: self)
        stackView.pinRight(to: self)
        stackView.pinTop(to: self, 12)
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColor = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.rgba.green,
                blue: chosenColor.rgba.blue,
                alpha: chosenColor.rgba.alpha
            )
        case 1:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red,
                green: CGFloat(slider.value),
                blue: chosenColor.rgba.blue,
                alpha: chosenColor.rgba.alpha
            )
        default:
            self.chosenColor = UIColor(
                red: chosenColor.rgba.red,
                green: chosenColor.rgba.green,
                blue: CGFloat(slider.value),
                alpha: chosenColor.rgba.alpha
            )
        }
        delegate?.changeColor(self)
        sendActions(for: .touchDragInside)
    }
}

