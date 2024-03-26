//
//  ImageCacheViewController.swift
//  MCBaseExample
//
//  Created by Miller Mosquera on 4/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import Combine
import Kingfisher

class ImageCacheViewController: MEMBaseViewController {
    
    private var cancellable: AnyCancellable?
    private var cancellableSet: Set<AnyCancellable> = []
    
    struct Constants {
        static let imageURL = "https://images.pexels.com/photos/20356890/pexels-photo-20356890/free-photo-of-a-narrow-street-with-stairs-leading-up-to-a-house.jpeg"
        static let imageURL2 = "https://images.pexels.com/photos/20230202/pexels-photo-20230202/free-photo-of-an-old-camera-sitting-on-top-of-a-newspaper.jpeg"
        static let imageURL3 = "https://images.pexels.com/photos/18163082/pexels-photo-18163082/free-photo-of-camera-and-iced-coffee-on-wooden-cafe-table.jpeg"
    
        static let dataImages = [imageURL, imageURL2, imageURL3]
    }
    
    let imgImageC: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    let imgImageAA: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let imgImageGCD: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    let textInput: UITextField = {
        let txt = UITextField(frame: .zero)
        txt.placeholder = "Try it out..."
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .line
        txt.becomeFirstResponder()
        return txt
    }()
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        showNavigationBar()
        setTextInput()
        setImageView()
        
        downloadImagesWithKF()
        //downloadImageCombine()
        //downloadImageAsyncAwait()
        //downloadImageGCD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImagesWithKF()
        //downloadImageCombine()
        //downloadImageAsyncAwait()
        //downloadImageGCD()
    }
    
    func setTextInput() {
        self.view.addSubview(textInput)
        NSLayoutConstraint.activate([
            textInput.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            textInput.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setImageView() {
        self.view.addSubview(imgImageC)
        self.view.addSubview(imgImageAA)
        self.view.addSubview(imgImageGCD)
        
        NSLayoutConstraint.activate([
            imgImageC.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 20),
            imgImageC.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 2),
            imgImageC.heightAnchor.constraint(equalToConstant: 200),
            imgImageC.widthAnchor.constraint(equalToConstant: 200),
            
            imgImageAA.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: 20),
            imgImageAA.leadingAnchor.constraint(equalTo: imgImageC.trailingAnchor, constant: 2),
            imgImageAA.heightAnchor.constraint(equalToConstant: 200),
            imgImageAA.widthAnchor.constraint(equalToConstant: 200),
            
            imgImageGCD.topAnchor.constraint(equalTo: imgImageC.bottomAnchor, constant: 2),
            imgImageGCD.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 2),
            imgImageGCD.heightAnchor.constraint(equalToConstant: 200),
            imgImageGCD.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func downloadImagesWithKF() {
        imgImageC.kf.indicatorType = .activity
        imgImageAA.kf.indicatorType = .activity
        imgImageGCD.kf.indicatorType = .activity
        
        imgImageC.kf.setImage(with: URL(string: Constants.imageURL))
        imgImageAA.kf.setImage(with: URL(string: Constants.imageURL2))
        imgImageGCD.kf.setImage(with: URL(string: Constants.imageURL3))
    }
    
    func downloadImageCombine() {
        /*let publisher = MCBImageLoader.shared.downloadImage(from: URL(string: Constants.imageURL)! )
        cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print("Error \(error)")
            }
        } receiveValue: { [weak self] image in
            if let image = image {
                self?.imgImageC.image = image
            }
        }*/
        
        Publishers.Sequence(sequence: Constants.dataImages)
            //.flatMap { data -> AnyPublisher<String, NSError> in }
            .collect()
            .receive(on: RunLoop.main)
            .sink { image in
                print("Downloaded")
            }
            .store(in: &cancellableSet)
    }
    
    func downloadImageAsyncAwait() {
        Task(priority: .background ){ @MainActor in
            let image = try await MEMBaseImageLoader.shared.downloadImage(from: URL(string: Constants.imageURL2)!)
            self.imgImageAA.image = image
        }
    }
    
    func downloadImageGCD() {
        MEMBaseImageLoader.shared.downloadImage(url: URL(string: Constants.imageURL3)!) { image in
            DispatchQueue.main.async {
                self.imgImageGCD.image = image
            }
        }
    }
    
}
