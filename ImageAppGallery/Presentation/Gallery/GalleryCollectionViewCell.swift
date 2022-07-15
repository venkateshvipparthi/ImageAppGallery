//
//  GalleryCollectionViewCell.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func prepareForReuse() {
        self.galleryImageView.image = nil
    }
}
