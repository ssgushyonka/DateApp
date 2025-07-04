import UIKit

final class MainTabsViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let vc1 = DumbViewController()
        let vc2 = FeedViewController()
        let vc3 = DumbViewController()
        let vc4 = DumbViewController()
        
        vc1.tabBarItem.image = UIImage(named: "icon-live")
        vc2.tabBarItem.image = UIImage(named: "icon-feed")
        vc3.tabBarItem.image = UIImage(named: "icon-chat")
        vc4.tabBarItem.image = UIImage(named: "icon-profile")

        vc1.tabBarItem.title = TabsStrings.live
        vc2.tabBarItem.title = TabsStrings.feed
        vc3.tabBarItem.title = TabsStrings.chat
        vc4.tabBarItem.title = TabsStrings.profile
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: false)
        
        tabBar.tintColor = .title
        tabBar.unselectedItemTintColor = .lightGray // тут сделала серым, чтобы было понятно на какой сейчас вкладке
        tabBar.backgroundColor = .white
        selectedIndex = 1
    }
}
