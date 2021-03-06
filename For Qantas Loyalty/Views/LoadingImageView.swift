//
//  LoadingImageView.swift
//  For Qantas Loyalty
//
//  Created by Dmitrii Zverev on 26/6/18.
//  Copyright © 2018 Dmitrii Zverev. All rights reserved.
//

import Foundation
import UIKit

class LoadingImageView: UIImageView {
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var imageLoader = ImageLoader()
    
    override func awakeFromNib() {
        self.backgroundColor = .groupTableViewBackground
        self.setAsEmpty()
        self.addSubview(loadingIndicator, constraints: {
            $0.centerY.alignWithSuperview()
            $0.centerX.alignWithSuperview()
        })
    }
    
    func fillWith(_ linkSting: String)  {
        if linkSting.isEmpty {
            self.setError()
            return
        }
        self.downloadImageFrom(urlString:linkSting)
    }
    
    private func downloadImageFrom(urlString: String) {
        self.loadingIndicator.startAnimating()
        imageLoader.downloadImageFrom(urlString: urlString) { (image) in
            self.loadingIndicator.stopAnimating()
            if let image = image {
                self.contentMode = .scaleToFill
                self.image = image
            } else {
                self.setError()
            }
        }
    }
    
    func setAsEmpty()  {
        self.contentMode = .center
        imageLoader.imageLoadingDataTask?.cancel()
        self.image = #imageLiteral(resourceName: "imagePlaceholder")
    }
    
    func setError()  {
        self.contentMode = .center
        self.image = #imageLiteral(resourceName: "imageError")
    }
    
}
