import UIKit

protocol ChangeColorProtocol: AnyObject {
    func changeColor(_ slider: ColorPaletteView)
}

class WelcomeViewController:UIViewController, ChangeColorProtocol  {
    private var commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton()
    private let commentView = UIView()
    var buttonsSV = UIStackView()
    private var value: Int = 0
    private var colorPaletteView = ColorPaletteView()
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        colorPaletteView.delegate = self
        view.backgroundColor = .blue
        //commentView.isHidden = true
        colorPaletteView.isHidden = true
        
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupCommentView()
        setupColorControlSV()
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
                                     colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
                                     colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
                                     colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -8)])
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.setTitleColor(.yellow, for: .disabled)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font =
            .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        
        incrementButton.layer.applyShadow()
        
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        
        incrementButton.pinLeft(to: self.view, 24)
        incrementButton.pinRight(to: self.view, 24)
        incrementButton.addTarget(self, action:
                                    #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        self.updateUI()
    }
    
    @objc
    private func updateUI() {
        valueLabel.text = "\(value)"
        self.view.backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "📝")
        let newsButton = makeMenuButton(title: "📰")
        
        colorsButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        
        notesButton.isEnabled = false
        newsButton.isEnabled = false
        
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, 24)
        buttonsSV.pinRight(to: self.view, 24)
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    @discardableResult
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, 24)
        commentView.pinRight(to: self.view, 24)
        
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentLabel.text = "Lorem ipsum dolor sit amet,\n consectetur adipiscing elit."
        
        commentView.addSubview(commentLabel)
        commentLabel.pinTop(to: commentView, 16)
        commentLabel.pinBottom(to: commentView, 16)
        commentLabel.pinLeft(to: commentView, 16)
        commentLabel.pinRight(to: commentView, 16)
        
        return commentView
    }
    
    func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
}
