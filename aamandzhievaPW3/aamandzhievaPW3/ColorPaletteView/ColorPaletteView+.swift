import UIKit

extension ColorPaletteView {
    class ColorSliderView: UIControl {
        private let slider = UISlider()
        private let colorLabel = UILabel()
        private var colorvalue = UILabel()
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            
            slider.value = value
            colorLabel.text = colorName
            colorLabel.textColor = .gray
            colorvalue.text = String(format: "%.3f", self.value)
            colorvalue.textColor = .gray
            setupView()
            slider.addTarget(self, action:
                                #selector(sliderMoved(_:)), for: .touchDragInside)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
            
        public func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider, colorvalue])
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            addSubview(stackView)
            stackView.pinBottom(to: self, 5)
            stackView.pinLeft(to: self, 12)
            stackView.pinRight(to: self, 12)
            stackView.pinTop(to: self, 12)
        }
            
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            colorvalue.text = String(format: "%.3f", self.value)
            sendActions(for: .touchDragInside)
            }
    }
}
