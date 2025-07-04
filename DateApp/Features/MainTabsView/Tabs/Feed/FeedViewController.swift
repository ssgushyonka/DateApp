import UIKit

final class FeedViewController: UIViewController {
    private let viewModel = FeedViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.reuseId)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var tabLabel: UILabel = {
        let label = UILabel()
        label.text = "Feed"
        label.font = UIFont.customFont(.latoExtraBold, size: 20)
        label.tintColor = .title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feedTypeSegments: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center

        let normalColor: UIColor = .silver
        let selectedColor: UIColor = .title
        let titles = ["Online", "Popular", "New", "Following"]
        titles.forEach { title in
            let label = UILabel()
            label.text = title
            label.font = UIFont.customFont(.latoExtraBold, size: 20)
            label.textColor = normalColor
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(segmentTapped(_:)))
            label.addGestureRecognizer(tap)
            stack.addArrangedSubview(label)
        }
        (stack.arrangedSubviews.first as? UILabel)?.textColor = selectedColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    @objc private func segmentTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLabel = sender.view as? UILabel else { return }
        feedTypeSegments.arrangedSubviews.forEach { view in
            (view as? UILabel)?.textColor = (view == selectedLabel) ? .title : .silver
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupViewModel()
        viewModel.loadProfiles()
    }

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(tabLabel)
        view.addSubview(feedTypeSegments)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tabLabel.heightAnchor.constraint(equalToConstant: 24),
            tabLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            tabLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            feedTypeSegments.heightAnchor.constraint(equalToConstant: 22),
            feedTypeSegments.topAnchor.constraint(equalTo: tabLabel.bottomAnchor, constant: 15),
            feedTypeSegments.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: feedTypeSegments.bottomAnchor, constant: 19),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupViewModel() {
        viewModel.onProfilesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.numberOfItems()
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.reuseId, for: indexPath) as! ProfileCell
        cell.configure(with: viewModel.profile(at: indexPath.item))
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 16
        let totalHorizontalPadding = padding * 2 + spacing
        let width = (collectionView.bounds.width - totalHorizontalPadding) / 2
        return CGSize(width: width, height: width * 1.4)
    }
}
