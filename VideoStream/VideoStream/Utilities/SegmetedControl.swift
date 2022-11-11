//
//  SegmetedControl.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 08/11/2022.
//

import UIKit

class UISegmentedView: UISegmentedControl {
    
}


extension UIImage {
    class func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

// extension for UISegmetedControl
// 0/255
extension UISegmentedControl {
    
    func removeBorder() {
        let background = UIImage.getSegRect(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0/255).cgColor, andSize: self.bounds.size)
        
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let dividerLine = UIImage.getSegRect(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: 1))
        self.setDividerImage(dividerLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constants.Colors.greyColor as Any], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constants.Colors.blackColor as Any], for: .selected)
    }
    
    func adjustFont() {
        let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: Constants.Colors.greyColor  as Any]
        self.setTitleTextAttributes(normalAttribute, for: .normal)
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: Constants.Colors.blackColor as Any]
        self.setTitleTextAttributes(selectedAttribute, for: .selected)
    }
    
    //tab highlight when selected
    func highlightSelectedSegment() {
        removeBorder()
        let lineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let lineHeight: CGFloat =  3.0 // set height of underline leight
        let lineXPosition = CGFloat(selectedSegmentIndex * (Int(lineWidth / 2) - 15))
        let lineYPosition = self.bounds.size.height - 6.0
        let underLineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underLineFrame)
        underLine.layer.cornerRadius = 3
        underLine.backgroundColor = Constants.Colors.blackColor
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    // set the postion of bottom underline
    func setUnderLinePosition() {
        guard let underline = self.viewWithTag(1) else {return}
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) 
        
        // spring animation when tab index is changed
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            underline.frame.origin.x = xPosition
        })
    }
    
}
