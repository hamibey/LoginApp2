import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = ReservationsViewController()
        // let vc2 = PropertiesViewController()
        let vc3 = ProfileViewController()
        
        vc1.title = "Reservations"
        // vc2.title = "Properties"
        vc3.title = "Profile"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        // vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        // let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.navigationBar.tintColor = .label
        // nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label

        nav1.tabBarItem = UITabBarItem(title: "Reservations", image: UIImage(systemName: "note.text"), tag: 1)
        // nav2.tabBarItem = UITabBarItem(title: "Properties", image: UIImage(systemName: "building"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        nav1.navigationBar.prefersLargeTitles = true
        // nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav3], animated: false)
    }
    
}
