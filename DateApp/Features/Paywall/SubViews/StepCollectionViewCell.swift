import UIKit

final class StepCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.latoExtraBold, size: 24)
        label.textColor = .title
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: PaywallStepConstants.textHeight),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PaywallStepConstants.textTop),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PaywallStepConstants.textLeading),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PaywallStepConstants.textLeading),
            
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: PaywallStepConstants.imageHeightMult),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PaywallStepConstants.topImageSpace),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    func configure(with step: PayWallStep) {
        imageView.image = UIImage(named: step.imageName)
        titleLabel.text = step.title
    }
}
