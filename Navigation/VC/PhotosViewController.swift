//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Shalopay on 17.06.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController {
    private var imagePublisherFacade = ImagePublisherFacade()
    var textTitle: String?
    private lazy var imagesArray = PostImage.makeArrayImage()
    private lazy var photos = [UIImage]()
    private var startTime = Date()
    private var imageProcessor: ImageProcessor?
    
    private enum Constants {
        static let numberOfLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupCollectionView()
        
        setupImageProcessor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = textTitle
        print("viewWillAppear")
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("viewWillDisappear")
        navigationController?.navigationBar.isHidden = true
        imagePublisherFacade.removeSubscription(for: self)
        imagePublisherFacade.rechargeImageLibrary()
    }
    
    private func setupImageProcessor() {
        let imageProcessor = ImageProcessor()
        //MARK: userInitiated - 2.19 секунды
        imageProcessor.processImagesOnThread(sourceImages: PostImage.makeArrayImage(countPhoto: 10, startIndex: 5), filter: .bloom(intensity: 30), qos: .userInteractive) { cgImages in
            for image in cgImages {
                self.photos.append(UIImage(cgImage: image!))
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
        }
        
//        //MARK: userInitiated - 3.85 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .bloom(intensity: 30), qos: .userInteractive) { cgImages in
//            for image in cgImages {
//                self.photos.append(UIImage(cgImage: image!))
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
//        }
        
//        //MARK: userInitiated - 4.27 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .bloom(intensity: 30), qos: .userInitiated) { cgImages in
//            for image in cgImages {
//                self.photos.append(UIImage(cgImage: image!))
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
//        }
        
//        //MARK: default - 3.79 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .motionBlur(radius: 60), qos: .default) { cgImages in
//            for image in cgImages {
//                self.photos.append(UIImage(cgImage: image!))
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
//        }
        
//        //MARK: background - 3.29 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .vignette(intensity: 70, radius: 30), qos: .background) { cgImages in
//            for image in cgImages {
//                self.photos.append(UIImage(cgImage: image!))
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
//        }

//        //MARK: utility - 3.12 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .noir, qos: .utility) { cgImages in
//            for image in cgImages {
//                self.photos.append(UIImage(cgImage: image!))
//            }
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//            print("Загрузка \(Date().timeIntervalSince(self.startTime)) секунд(ы)")
//        }
    }
    
    private func setupImagePublisherFacade() {
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: imagesArray)
        
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        
        
        
        
        cell.setup(image: photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section - \(indexPath.section) - Item \(indexPath.item)")
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let needed = collectionView.frame.width - (Constants.numberOfLine - 1) * spacing - insets.left - insets.right
        let itemwidth = floor(needed / Constants.numberOfLine)
        return CGSize(width: itemwidth, height: itemwidth)
    }
}
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        photos = images
    collectionView.reloadData()
    }
}
