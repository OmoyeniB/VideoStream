//
//  VideoTableViewCell.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 08/11/2022.
//

import UIKit
import SnapKit

class VideoTableViewCell: UITableViewCell {
    
    let audioPlayerManager = AudioPlayerManager()
    static let identifier = "VideoTableViewCell"
    
   let activityIndicator = UIActivityIndicatorView()
      
    lazy var profileImage: UIImageView = {
        var profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .clear
        profileImage.layer.cornerRadius = 25
        return profileImage
    }()
    
    lazy var userName: UILabel = {
        var userName = UILabel()
        userName.textColor = Constants.Colors.blackColor
        return userName
    }()
    
    lazy var datePosted: UILabel = {
        var datePosted = UILabel()
        datePosted.textColor = Constants.Colors.blackColor
        return datePosted
    }()
    
    lazy var postDescription: UILabel = {
        var postDescription = UILabel()
        postDescription.textColor = Constants.Colors.blackColor
        postDescription.numberOfLines = 0
        postDescription.textAlignment = .left
        return postDescription
    }()
    
    lazy var videoView: UIView = {
        var videoView = UIView()
        videoView.contentMode = .scaleToFill
        return videoView
    }()
 
    lazy var volumeButton: UIButton = {
        var volumeButton = UIButton()
        volumeButton.setImage(UIImage(named: Constants.Images.mutedSpeaker), for: .normal)
        volumeButton.addTarget(self, action: #selector(controlAudioVoulme), for: .touchUpInside)
        volumeButton.clipsToBounds = true
        return volumeButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContraints()
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func controlAudioVoulme(_ sender: UIButton) {
        
        if audioPlayerManager.player?.volume == 0 {
            audioPlayerManager.mute_unmute_Video(volume: 5)
            volumeButton.setImage(UIImage(named: Constants.Images.unmutedSpeaker), for: .normal)
        } else {
            DispatchQueue.main.async { [self] in
                audioPlayerManager.mute_unmute_Video(volume: 0)
                volumeButton.setImage(UIImage(named: Constants.Images.mutedSpeaker), for: .normal)
            }
        }
    }
    
    func setContraints() {
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(datePosted)
        contentView.addSubview(postDescription)
        contentView.addSubview(videoView)
       videoView.addSubview(activityIndicator)
        contentView.addSubview(volumeButton)
        
        profileImage.snp.makeConstraints({ make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.height.width.equalTo(50)
        })
        
        userName.snp.makeConstraints({make in
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.top.equalTo(contentView.snp.top).offset(20)
        })
        
        datePosted.snp.makeConstraints({make in
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.top.equalTo(userName.snp.bottom).offset(5)
        })
        
        postDescription.snp.makeConstraints({ make in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.right.equalTo(contentView.snp.right).inset(20)
        })
        
        videoView.snp.makeConstraints({ make in
            make.top.equalTo(postDescription.snp.bottom).offset(20)
            make.right.equalTo(contentView.snp.right).inset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        })
        
        activityIndicator.snp.makeConstraints({make in
            make.centerX.equalTo(videoView.snp.centerX)
            make.centerY.equalTo(videoView.snp.centerY)
            make.height.width.equalTo(40)
        })
        
        volumeButton.snp.makeConstraints({make in
            make.right.equalTo(contentView.snp.right).inset(50)
            make.bottom.equalTo(contentView.snp.bottom).inset(30)
            make.height.width.equalTo(20)
        })
    }
    
    func setUpCell(with videoModel: PersistedObject, indexPath: IndexPath) {
        datePosted.text = contentView.getFormattedDate(string: String(videoModel.timeStamp), formatter: "yyyy-MM-dd HH:mm:ss Z")
        contentView.downloadImage(with: videoModel.photo, images: profileImage)
        userName.text = videoModel.userName
        
        postDescription.text = videoModel.decsription
        if videoModel.isVideo == true {
            DispatchQueue.main.async {
                self.audioPlayerManager.loadVideo(videoModel.videoLink, videoView: self.videoView)
            }
        }
    }
   
}
