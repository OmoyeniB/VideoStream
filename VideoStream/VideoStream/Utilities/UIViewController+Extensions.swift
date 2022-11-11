//
//  UIViewController+Extensions.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//


import UIKit

extension UIViewController {
    
    public func popUpAlert(title: String, message: String, alertStyle: UIAlertController.Style,
                           actionTitles: [String], actionStyles: [UIAlertAction.Style],
                           actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle,
                                       style: actionStyles[index],
                                       handler: actions[index])
            
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true)
    }
    
    public func displayError(error: String) {
        
        DispatchQueue.main.async {
            self.popUpAlert(title: Constants.PopUpAlertString.popUpTitle,
                            message: error,
                            alertStyle: .alert,
                            actionTitles: [Constants.PopUpAlertString.popUpActionTitles], actionStyles: [.default], actions: [ { _ in
            }])
        }
        
    }
    
    
    func addCustomButtonInNavigationBar(button: UIButton) -> UIBarButtonItem {
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return menuBarItem
    }

    func configureSegmentedControl(_ segmentedControl: UISegmentedView) {
        segmentedControl.frame = CGRect(x: segmentedControl.frame.minX, y:
                                            segmentedControl.frame.minY,
                                        width: segmentedControl.frame.width, height: 30)
        segmentedControl.highlightSelectedSegment()
    }
}
