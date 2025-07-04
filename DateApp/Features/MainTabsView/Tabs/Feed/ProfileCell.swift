import UIKit

final class ProfileCell: UICollectionViewCell {
    static let reuseId = "ProfileCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = .lightGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(.latoExtraBold, size: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flag")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var onlineIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 9
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        let label = UILabel()
        label.font = UIFont.customFont(.latoBold, size: 10)
        label.textColor = .white
        label.text = "online"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let circle = UIView()
        circle.layer.cornerRadius = 4
        circle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addSubview(circle)

        NSLayoutConstraint.activate([
            circle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            circle.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            circle.widthAnchor.constraint(equalToConstant: 7),
            circle.heightAnchor.constraint(equalToConstant: 7),

            label.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 3),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 3),
            
            view.heightAnchor.constraint(equalToConstant: 19),
            view.widthAnchor.constraint(equalToConstant: 52)
        ])
        return view
    }()

    private lazy var chatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-chat-label"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn-live"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-favorite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryImageView)
        contentView.addSubview(onlineIndicator)
        contentView.addSubview(chatButton)
        contentView.addSubview(callButton)
        contentView.addSubview(likeButton)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemGray5
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            onlineIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            onlineIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            
            countryImageView.heightAnchor.constraint(equalToConstant: 14),
            countryImageView.widthAnchor.constraint(equalToConstant: 14),
            countryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 41),
            countryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 168),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 166),
            nameLabel.leadingAnchor.constraint(equalTo: countryImageView.trailingAnchor, constant: 5),
            
            chatButton.heightAnchor.constraint(equalToConstant: 21),
            chatButton.widthAnchor.constraint(equalToConstant: 21),
            chatButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            chatButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            
            callButton.heightAnchor.constraint(equalToConstant: 32),
            callButton.widthAnchor.constraint(equalToConstant: 32),
            callButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            callButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            likeButton.heightAnchor.constraint(equalToConstant: 21),
            likeButton.widthAnchor.constraint(equalToConstant: 21),
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25)
        ])
    }

    func configure(with profile: Profile) {
        nameLabel.text = "\(profile.name), \(profile.age)"

        if let onlineLabel = onlineIndicator.subviews.first as? UILabel,
           let onlineCircle = onlineIndicator.subviews.last {
            onlineLabel.text = profile.isOnline ? "online" : "offline"
            onlineCircle.backgroundColor = profile.isOnline ?
                .online : .gray
        }

        if let firstPhoto = profile.imageURL {
            loadImage(from: firstPhoto)
        }
    }

    private func loadImage(from url: URL) {
        let cacheKey = url.absoluteString as NSString
        if let cachedImage = ImageCache.shared.image(for: cacheKey) {
            self.imageView.image = cachedImage
            return
        }

        ImageCache.shared.loadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}
