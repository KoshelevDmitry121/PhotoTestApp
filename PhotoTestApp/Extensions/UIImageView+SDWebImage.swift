//
//  UIImageView+SDWebImage.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import SDWebImage
import UIKit

extension UIImageView {

    func loadImage(from urlString: String, with indicator: SDWebImageActivityIndicator? = .gray) {
        image = nil
        sd_imageIndicator = indicator
        guard let urlAllowed = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
              let url = URL(string: urlAllowed) else { return }
        DispatchQueue.main.async {
            self.sd_setImage(with: url,
                             placeholderImage: UIImage(named: "imagePlaceholder"),
                             options: [.highPriority])
            
        }
    }

}
