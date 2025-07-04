import UIKit

final class PayWallViewController: UIViewController {
    private let viewModel = PayWallViewModel()
    private var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }

    private let gradientView: PaywallGradientView = {
        let gradientView = PaywallGradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        return gradientView
    }()

    private lazy var ellipseLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let ellipseWidth: CGFloat = PaywallLayout.Ellipse.width
        let ellipseHeight: CGFloat = PaywallLayout.Ellipse.height
        let bottomInset: CGFloat = PaywallLayout.Ellipse.bottomInset
        let x: CGFloat = PaywallLayout.Ellipse.xPosition
        let y = view.bounds.height - ellipseHeight - bottomInset
        let path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: ellipseWidth, height: ellipseHeight))
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StepCollectionViewCell.self, forCellWithReuseIdentifier: "StepCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = PaywallStrings.MainLabel.text
        label.textColor = .white
        label.font = UIFont.customFont(.latoSemibold, size: 16)
        label.setLetterSpacing(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = PaywallStrings.SubLabel.text
        label.textColor = .white
        label.font = UIFont.customFont(.latoRegular, size: 13)
        label.setLetterSpacing(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle(PaywallStrings.Buttons.suscribeTitle, for: .normal)
        button.titleLabel?.font = UIFont.customFont(.interSemiBold, size: 18)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subscribeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-close"), for: .normal)
        button.tintColor = .silver
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle(PaywallStrings.Buttons.restoreTitle, for: .normal)
        button.titleLabel?.font = UIFont.customFont(.latoRegular, size: 16)
        button.titleLabel?.setLetterSpacing(0.5)
        button.tintColor = .clear
        button.setTitleColor(.silver, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restoreTapped), for: .touchUpInside)
        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = viewModel.stepsCount
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .disabledPage
        pageControl.currentPageIndicatorTintColor = .currentPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        view.layer.insertSublayer(ellipseLayer, at: 1)
        setupSubscribeButtonGradient()
    }
    
    private func setupSubscribeButtonGradient() {
        subscribeButton.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        let gradient = GradientElements.suscribeButtonGradient(frame: subscribeButton.bounds, cornerRadius: 24)
        subscribeButton.layer.insertSublayer(gradient, at: 0)
    }

    private func setupViews() {
        view.insertSubview(gradientView, at: 0)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(closeButton)
        view.addSubview(restoreButton)
        view.addSubview(subscribeButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: PaywallLayout.Buttons.closeButtonSize),
            closeButton.widthAnchor.constraint(equalToConstant: PaywallLayout.Buttons.closeButtonSize),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: PaywallLayout.Buttons.closeButtonTop),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PaywallLayout.Buttons.closeButtonLeading),

            restoreButton.widthAnchor.constraint(equalToConstant: PaywallLayout.Buttons.restoreButtonWidth),
            restoreButton.topAnchor.constraint(equalTo: view.topAnchor, constant: PaywallLayout.Buttons.restoreButtonTop),
            restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: PaywallLayout.Buttons.restoreButtonTrailing),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -260),

            mainLabel.heightAnchor.constraint(equalToConstant: PaywallLayout.Labels.mainLabelHeight),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: PaywallLayout.Labels.Spacing.bottomPageControl),
            mainLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: PaywallLayout.Labels.Insets.mainLabelLeading),
            mainLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -PaywallLayout.Labels.Insets.mainLabelTrailing),
            
            subLabel.heightAnchor.constraint(equalToConstant: PaywallLayout.Labels.subLabelHeight),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: PaywallLayout.Labels.Spacing.betweenLabels),
            subLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: PaywallLayout.Labels.Insets.subLabelLeading),
            subLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -PaywallLayout.Labels.Insets.subLabelTrailing),
            
            subscribeButton.heightAnchor.constraint(equalToConstant: PaywallLayout.Buttons.subButtonHeight),
            subscribeButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: PaywallLayout.Buttons.subButtonTopSpace),
            subscribeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PaywallLayout.Buttons.subButtonLeading),
            subscribeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PaywallLayout.Buttons.subButtonLeading)
        ])
    }

    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func restoreTapped() {
        Task {
            let success = await SubscriptionManager.shared.restorePurchase()

            if success {
                print("Purchases have been successfully restored")
            } else {
                print("Error")
            }
        }
    }
    
    @objc private func subscribeTapped() {
        if let product = SubscriptionManager.shared.trialProduct {
            SubscriptionManager.shared.buySubscription(product) { success in
                if success {
                    print("Success")
                } else {
                    print("Error")
                }
            }
        } else {
            print("Error")
        }
    }
}

extension PayWallViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.stepsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let step = viewModel.steps[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StepCell", for: indexPath) as! StepCollectionViewCell
        cell.configure(with: step)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        pageControl.currentPage = page
    }
}
