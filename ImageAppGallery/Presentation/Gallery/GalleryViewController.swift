//
//  GalleryViewController.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    var galleryViewModel: GalleryViewModel?
    
    private var columnCount: Int {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return Constants.iPadColumnCount
        default:
            return Constants.iPhoneColumnCount
        }
    }
    private let minimumInteritemSpacing: CGFloat = 10.0
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("gallery", comment:"")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout = flowLayout
    }

}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryViewModel?.numberOfRecords ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        Task {
            if let data =    await galleryViewModel?.downLoadImage(for:indexPath.row) { cell.galleryImageView.image = UIImage(data: data)
            }else {
                cell.galleryImageView.image = UIImage(named:"defaultImage")
            }
            
        }
        
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideInsets = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        let spaceBetween = minimumInteritemSpacing * CGFloat(columnCount - 1)
        
        let cellWidth = (collectionView.bounds.width - (sideInsets + spaceBetween)) / CGFloat(columnCount)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
