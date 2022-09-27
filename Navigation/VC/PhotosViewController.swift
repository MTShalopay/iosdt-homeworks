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
    private lazy var postImage = PostImage.setupImages()
    private lazy var imagesArray = PostImage.makeArrayImage()
    private lazy var photos = [UIImage]()
    private var timer: Timer?
    private var milliseconds = 0
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
        startTimer()
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
//        //MARK: background - 4 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .bloom(intensity: 10), qos: .background) { [weak self] _ in
//            self?.stopTimer()
//        }
//        //MARK: default - 3 секунды
//        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .chrome, qos: .default) { [weak self] _ in
//            self?.stopTimer()
//        }
//        //MARK: userInitiated - 4 секунды
//        imageProcessor.processImagesOnThread(sourceImages: PostImage.makeArrayImage(countPhoto: 20, startIndex: 4), filter: .crystallize(radius: 90), qos: .userInitiated) { [weak self] _ in
//            self?.stopTimer()
//        }
//        //MARK: userInteractive - 4 секунды
//        imageProcessor.processImagesOnThread(sourceImages: PostImage.makeArrayImage(countPhoto: 20, startIndex: 2), filter: .crystallize(radius: 90), qos: .userInteractive) { [weak self] _ in
//            self?.stopTimer()
//        }
        //MARK: utility - 5 секунды
        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .crystallize(radius: 90), qos: .utility) { [weak self] _ in
            self?.stopTimer()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(counter),
                                     userInfo: nil,
                                     repeats: true)
    }
    @objc func counter() {
        milliseconds += 1
    }
    private func stopTimer() {
        timer?.invalidate()
        print("\(milliseconds) секунд(ы)")
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
        return imagesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath)}
        cell.setup(image: imagesArray[indexPath.item])
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
