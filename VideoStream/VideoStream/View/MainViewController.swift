//
//  ViewController.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 07/11/2022.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore


class MainViewController: UIViewController {
    
    let audioPlayerManager = AudioPlayerManager()
    var filteredVideoModel = [VideoModel]()
    let viewModel = VideoPostViewModel()
    var currentId: Int = 0
    var usersProfile: UsersModel?
    
    @IBOutlet weak var users_name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var usersBio: UILabel!
    @IBOutlet weak var usersProfileImage: UIImageView!
    @IBOutlet weak var segmentedControlTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    lazy var editProfileButton: UIButton = {
        var editProfileButton = UIButton(frame: CGRect(x: -13, y: 0.0, width: 35, height: 35))
        if #available(iOS 13.0, *) {
            editProfileButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
            
        } else {
            editProfileButton.setImage(UIImage(named: "edit"), for: .normal)
        }
        editProfileButton.tintColor = Constants.Colors.blackColor
        editProfileButton.addTarget(self, action: #selector(navigateToEditProfile), for: .touchUpInside)
        return editProfileButton
    }()
    
    @objc func navigateToEditProfile() {
        let editProfilepage = EditProfileViewController()
        editProfilepage.userData = self.usersProfile
        self.navigationController?.pushViewController(editProfilepage, animated: true)
    }
    
    lazy var backButton: UIButton = {
        var backButton = UIButton(frame: CGRect(x: 0, y: 0.0, width: 35, height: 35))
        if #available(iOS 13.0, *) {
            backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        } else {
            backButton.setImage(UIImage(named: "back"), for: .normal)
        }
        backButton.tintColor = Constants.Colors.blackColor
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.isEnabled = false
        viewModel.configureSegmentedControl(segmentedControl)
        segmentedControl.setUnderLinePosition()
        fetchDataFromFireBase()
        fetchDataFromViewModel()
        audioPlayerManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavbar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpNavbar() {
        let leftNavItem = addCustomButtonInNavigationBar(button: backButton)
        let rightNavItem = addCustomButtonInNavigationBar(button: editProfileButton)
        self.navigationItem.rightBarButtonItem = rightNavItem
        self.navigationItem.leftBarButtonItem = leftNavItem
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
}
extension MainViewController: UITableViewDataSource {
    
