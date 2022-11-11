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
import ProgressHUD

class MainViewController: UIViewController {
    
    let audioPlayerManager = AudioPlayerManager()
    var filteredpersistedData = [PersistedObject]()
    var data = [PersistedObject]()
    let viewModel = VideoPostViewModel()
    var currentId: Int = 0
    var usersProfile: UsersModel?
    
    @IBOutlet weak var users_name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var usersBio: UILabel!
    @IBOutlet weak var usersProfileImage: UIImageView!
    @IBOutlet weak var segmentedControlTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIStackView!
    @IBOutlet weak var segmentedControl: UISegmentedView!
    @IBOutlet weak var tableView: UITableView!
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
        return editProfileButton
    }()
    
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
        setUpTableView()
        configureSegmentedControl(segmentedControl)
        segmentedControl.setUnderLinePosition()
        viewModel.fetchDataFrromServer()
        fetchUsersDataFromServer()
        audioPlayerManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavbar()
        ProgressHUD.show("loading...")
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
    
    func getDataFromCompletion() {
        self.viewModel.completion = { [weak self] result in
            switch result{
            case .success(let data):
                self?.filteredpersistedData = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                ProgressHUD.dismiss()
                self?.displayError(error: error.localizedDescription)
            }
        }
    }
    
    func fetchUsersDataFromServer() {
        getDataFromCompletion()
        viewModel.fetchUsersDataFromServiceClass(completion: {[weak self] result in
            if let self = self {
                switch result {
                case .success(let usersData):
                    self.usersProfile = usersData
                    DispatchQueue.main.async {
                        self.users_name.text = self.usersProfile?.name
                        self.userName.text = self.usersProfile?.username
                        self.usersBio.text = self.usersProfile?.bio
                        self.view.downloadImage(with: self.usersProfile?.photo ?? "", images: self.usersProfileImage)
                        ProgressHUD.dismiss()
                    }
                case .failure(let error):
                    ProgressHUD.dismiss()
                    self.displayError(error: error.localizedDescription)
                }
            }
        })
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.identifier)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredpersistedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell {
            cell.setUpCell(with: filteredpersistedData[indexPath.row], indexPath: indexPath)
            if let player = audioPlayerManager.player {
                if player.rate == 0 {
                    player.pause()
                    audioPlayerManager.mute_unmute_Video(volume: 0)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
}

extension MainViewController: UITableViewDelegate {
    
    //MARK: - Scrolling Config
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == tableView {
            if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
                viewModel.animateHeaderViewToZero(headerHeight: headerHeight, profileImageHeight: profileImageHeight, view: view)
                
            } else {
                viewModel.animateHeader(headerHeight: headerHeight, profileImageHeight: profileImageHeight, view: self.view)
            }
        }
    }
    
}

extension MainViewController: AudioPlayerManagerDelegate {
    
    func audioPlayerError(error: Error) {
        self.displayError(error: NetworkingError.invalidUrl.localizedDescription)
    }
    
}
