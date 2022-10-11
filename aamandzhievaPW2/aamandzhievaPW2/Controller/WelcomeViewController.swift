import UIKit

final class WelcomeViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let incrementButton = UIButton()
    private let commentView = UIView()
    private var value: Int = 0
    
    override func viewDidLoad() {
        setupView()
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

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,
                                      weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }

    @objc
    func setupView() {
        view.backgroundColor = .systemGray6
        
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        updateCommentLabel(value: value)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 1, animations: {
            self.updateColorView(value: self.value)
            self.updateUI()
        })
    }
    
    func updateColorView(value: Int) {
        if (value % 10 == 0) {
            incrementButton.isEnabled = false
            self.view.backgroundColor = UIColor(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1
            )
            self.commentLabel.textColor = self.view.backgroundColor
            incrementButton.isEnabled = true
        }
    }
    
    @objc
    private func updateUI() {
        valueLabel.text = "\(value)"
    }
    
    @discardableResult
    private func setupCommentView() -> UIView {
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, 24)
        commentView.pinRight(to: self.view, 24)
        
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentView.addSubview(commentLabel)
        commentLabel.pinTop(to: commentView, 16)
        commentLabel.pinBottom(to: commentView, 16)
        commentLabel.pinLeft(to: commentView, 16)
        commentLabel.pinRight(to: commentView, 16)
        
        return commentView
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
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
        
        let buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, 24)
        buttonsSV.pinRight(to: self.view, 24)
        buttonsSV.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
}
