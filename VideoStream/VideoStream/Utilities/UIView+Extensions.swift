//
//  UIView+Extensions.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//

import UIKit
import SDWebImage

extension UIView {
    
    func downloadImage(with url: String, images: UIImageView){
        
        images.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        if let url = URL(string: url) {
            images.sd_setImage(with: url) { (image, error, cache, urls) in
                if (error != nil) {
                    images.image = UIImage(named: "placeholderr")
                } else {
                    DispatchQueue.main.async {
                        images.image = image
                    }
                }
            }
        }
    }

    func getFormattedDate(string: String, formatter: String) -> String{
        let date = Date(timeIntervalSince1970: Double(string) ?? 0.0)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = formatter
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, h:mm a."
        let showDate = inputFormatter.string(from: date)
        let dateToString = inputFormatter.date(from: showDate)
        let resultString = outputFormatter.string(from: date)
        return resultString
    }

}

