//
//  Extensions.swift
//  LowblawCodeChallenge
//
//  Created by Bhadresh Radadiya on 2020-09-26.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(from link: String?, contentMode mode: UIView.ContentMode, completion: ((Bool) -> Void)? = nil) {
        contentMode = mode
        if link != nil, let imgUrl = URL(string: link!) {
            URLSession.shared.dataTask(with: imgUrl) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error in image download.")
                    completion?(false)
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                completion?(true)
            }.resume()
        }
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
