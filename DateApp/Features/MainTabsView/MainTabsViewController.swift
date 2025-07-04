import UIKit

final class MainTabsViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTabs() {
        let vc1 = DumbViewController()
        let vc2 = DumbViewController()
        let vc3 = DumbViewController()
        let vc4 = DumbViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "icon-live")
        vc2.tabBarItem.image = UIImage(systemName: "icon-feed")
        vc3.tabBarItem.image = UIImage(systemName: "icon-chat")
        vc4.tabBarItem.image = UIImage(systemName: "icon-profile")

        vc1.tabBarItem.title = TabsStrings.live
        vc2.tabBarItem.title = TabsStrings.feed
        vc3.tabBarItem.title = TabsStrings.chat
        vc3.tabBarItem.title = TabsStrings.profile
    }
}
