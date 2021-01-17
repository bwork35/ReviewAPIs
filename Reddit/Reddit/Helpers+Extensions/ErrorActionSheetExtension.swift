//
//  ErrorActionSheetExtension.swift
//  Reddit
//
//  Created by Bryan Workman on 1/16/21.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error!", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
    
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
} //End of extension
