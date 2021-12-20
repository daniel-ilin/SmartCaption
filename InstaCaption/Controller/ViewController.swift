//
//  ViewController.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 19.12.2021.
//

import UIKit
import TOCropViewController

class ViewController: UIViewController {

//    MARK: - Properties
    
    private var selectedImage: UIImage? {
        didSet {
            handleImageChanged()
        }
    }
    
    private var selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    private let tapUploadPhoto: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
        
        let largeTitle = UIImage.SymbolConfiguration(pointSize: 180)
        let black = UIImage.SymbolConfiguration(weight: .light)
        let config = largeTitle.applying(black)
        
        button.setImage(UIImage(systemName: "plus.square", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(handleTapToSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private let changePhotoButton: UIButton = {
        let button = OpaqueOrNotButton()
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 18)]
        let attributedTitle = NSAttributedString(string: "Tap to change photo", attributes: atts)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleTapToSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    private var helpTitle: UILabel = {
        let label = UILabel()
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 18)]
        label.attributedText = NSAttributedString(string: "Tap to add photo", attributes: atts)
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = AnimatedButton()
        button.setTitle("Generate SmartCaption", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.4)
        button.setTitleColor(.white.withAlphaComponent(0.67), for: .normal)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(submitImage), for: .touchUpInside)
        return button
    }()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        configureUI()
    }
    
//    MARK: - Helpers
    
    func configureUI() {
        view.addSubview(tapUploadPhoto)
        tapUploadPhoto.centerX(inView: view)
        tapUploadPhoto.anchor(bottom: view.centerYAnchor, paddingBottom: -10)
        
        view.addSubview(helpTitle)
        helpTitle.centerX(inView: view, topAnchor: tapUploadPhoto.bottomAnchor, paddingTop: 10)
        
        view.addSubview(submitButton)
        submitButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 25, paddingBottom: 100, paddingRight: 25)
        
        view.addSubview(selectedImageView)
        selectedImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: submitButton.leftAnchor, bottom: submitButton.topAnchor, right: submitButton.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 125, paddingRight: 0)
        
        view.addSubview(changePhotoButton)
        changePhotoButton.centerX(inView: view)
        changePhotoButton.anchor(top: selectedImageView.bottomAnchor, paddingTop: 10)
        
    }
    
    func handleImageChanged() {
        guard selectedImage != nil else { return }
        let buttonViewModel = ButtonViewModel(image: selectedImage!)
        submitButton.backgroundColor = buttonViewModel.buttonBackgroundColor
        submitButton.setTitleColor(buttonViewModel.buttonTitleColor, for: .normal)
        submitButton.isEnabled = buttonViewModel.formIsValid
        
        let imageViewModel = ImageViewModel(image: selectedImage!)
        selectedImageView.image = selectedImage
        selectedImageView.backgroundColor = imageViewModel.imageViewBackgroundColor
        
        tapUploadPhoto.isHidden = buttonViewModel.formIsValid
        helpTitle.isHidden = buttonViewModel.formIsValid
        changePhotoButton.isHidden = !buttonViewModel.formIsValid
    }
    
    func showImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        pickerController.modalPresentationStyle = .fullScreen
        present(pickerController, animated: true, completion: nil)
    }

//    MARK: - Actions
    
    @objc func handleTapToSelectPhoto() {
        showImagePicker()        
    }
    
    @objc func submitImage() {
        print("DEBUG: Submitted the image!")
    }

}


// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        cropSelectedImage(image)
        showLoader(true)
    }
}

extension ViewController: TOCropViewControllerDelegate {
    
    func cropSelectedImage(_ image: UIImage) {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        dismiss(animated: true) {
            self.showLoader(false)
            self.present(cropViewController, animated: true, completion: nil)
        }
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        selectedImage = image
        dismiss(animated: true, completion: nil)
    }
    
}
