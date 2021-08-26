//
//  Utilities.swift
//  Assignment-Volvo
//
//  Created by user on 26/08/21.
//

import Foundation
import UIKit

///Description - String extension to encode url.
extension String {
    var encodedURLString: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}

///Description - UIViewController  extension to display action sheet with information.
extension UIViewController {
     func displayErrorMessage(errMessage: String) {
        let actionSheet = UIAlertController(title: "Error", message: errMessage, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}
