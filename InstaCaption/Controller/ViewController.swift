//
//  ViewController.swift
//  InstaCaption
//
//  Created by Daniel Ilin on 19.12.2021.
//

import UIKit
import TOCropViewController
import JGProgressHUD

class ViewController: UIViewController {
    
    //    MARK: - Properties
    
    private var selectedImageTags = [ImageTag]()
    
    private var selectedImage: UIImage? {
        didSet {
            handleImageChanged()
        }
    }
    
    private var flipButton: UIButton = {
        let button = AnimatedButton()
        button.contentMode = .scaleAspectFill
        button.tintColor = .white
        
        let largeTitle = UIImage.SymbolConfiguration(pointSize: 20)
        let black = UIImage.SymbolConfiguration(weight: .regular)
        let config = largeTitle.applying(black)
        
        button.setImage(UIImage(systemName: "arrow.2.squarepath", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(flipMainViews), for: .touchUpInside)
        button.isEnabled = false
        button.isHidden = true
        return button
    }()
    
    private var selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    private var tagsTitle: UILabel = {
        let label = UILabel()
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 1), .font: UIFont.boldSystemFont(ofSize: 36)]
        let attributedText = NSAttributedString(string: "Tags", attributes: atts)
        label.attributedText = attributedText
        return label
    }()
    
    private var quoteTitle: UILabel = {
        let label = UILabel()
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 1), .font: UIFont.boldSystemFont(ofSize: 36)]
        let attributedText = NSAttributedString(string: "Quote", attributes: atts)
        label.isHidden = true
        label.attributedText = attributedText
        return label
    }()
    
    private var quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "• coming soon"
        label.isHidden = true
        label.textColor = .white
        return label
    }()
    
    private var tagsListLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "No tags found"
        label.textColor = .white
        return label
    }()
    
    private var selectedImageContainer: UIView = {
        let v = UIView()
        v.isHidden = true
        v.clipsToBounds = true
        return v
    }()
    
    private var imageTagView: UIView = {
        let iv = UIView()
        iv.clipsToBounds = true
        iv.isHidden = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.layer.cornerRadius = 15
        iv.backgroundColor = UIColor(white: 1, alpha: 0.15)
        return iv
    }()
    
    private let tapUploadPhoto: UIButton = {
        let button = AnimatedButton()
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
        
        
        view.addSubview(selectedImageContainer)
        selectedImageContainer.addSubview(selectedImageView)
        selectedImageContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: submitButton.leftAnchor, bottom: submitButton.topAnchor, right: submitButton.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 125, paddingRight: 0)
        selectedImageView.anchor(top: selectedImageContainer.topAnchor, left: selectedImageContainer.leftAnchor, bottom: selectedImageContainer.bottomAnchor, right: selectedImageContainer.rightAnchor)
        
        
        view.addSubview(changePhotoButton)
        changePhotoButton.centerX(inView: view)
        changePhotoButton.anchor(top: selectedImageContainer.bottomAnchor, paddingTop: 10)
        
        view.addSubview(imageTagView)
        imageTagView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: submitButton.leftAnchor, bottom: submitButton.topAnchor, right: submitButton.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 125, paddingRight: 0)
        
        imageTagView.addSubview(tagsTitle)
        tagsTitle.anchor(top: imageTagView.topAnchor, left: imageTagView.leftAnchor, paddingTop: 18, paddingLeft: 18)
        
        imageTagView.addSubview(tagsListLabel)
        tagsListLabel.anchor(top: tagsTitle.bottomAnchor, left: imageTagView.leftAnchor, paddingTop: 10, paddingLeft: 20)
        
        imageTagView.addSubview(quoteTitle)
        quoteTitle.anchor(top: tagsListLabel.bottomAnchor, left: imageTagView.leftAnchor, paddingTop: 18, paddingLeft: 18)
        
        imageTagView.addSubview(quoteLabel)
        quoteLabel.anchor(top: quoteTitle.bottomAnchor, left: imageTagView.leftAnchor, paddingTop: 10, paddingLeft: 20)
        
        view.addSubview(flipButton)
        flipButton.centerX(inView: view)
        flipButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 5)
        
    }
    
    func handleImageChanged() {
        guard selectedImage != nil else { return }
        let buttonViewModel = ButtonViewModel(image: selectedImage!)
        submitButton.backgroundColor = buttonViewModel.buttonBackgroundColor
        submitButton.setTitleColor(buttonViewModel.buttonTitleColor, for: .normal)
        submitButton.isEnabled = buttonViewModel.formIsValid
        flipButton.isEnabled = buttonViewModel.formIsValid
        flipButton.isHidden = !buttonViewModel.formIsValid
        selectedImageContainer.isHidden = false
        
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
    
    func requestTags(forId id: String) {
        TaggingService.getTagsForImageId(id) { imageTags in
            DispatchQueue.main.sync {
                self.showLoader(false)
                self.selectedImageTags.removeAll()
                self.selectedImageTags = self.filterImageTags(imageTags)
                self.showTagsToUser()
            }
        }
    }
    
    func filterImageTags(_ data: ImageData) -> [ImageTag] {
        
        let allTags = data.result.tags
        var newTags = [ImageTag]()
        if allTags.count > 5 {
            let shortList = allTags[0...4]
            newTags = shortList.map {ImageTag(imageTag: $0.tag.en)}
        } else {
            newTags = allTags.map{ImageTag(imageTag: $0.tag.en)}
        }
        
        return newTags
    }
    
    func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        flipButton.isEnabled = false
        
        if imageTagView.isHidden {
            UIView.transition(with: selectedImageContainer, duration: 1.0, options: transitionOptions, animations: {
                self.selectedImageContainer.alpha = 0
                self.selectedImageContainer.isHidden = true
                self.flipButton.isEnabled = true
            })
            
            UIView.transition(with: imageTagView, duration: 1.0, options: transitionOptions, animations: {
                self.imageTagView.alpha = 1
                self.imageTagView.isHidden = false
                self.flipButton.isEnabled = true
            })
        } else {
            UIView.transition(with: selectedImageContainer, duration: 1.0, options: transitionOptions, animations: {
                self.selectedImageContainer.alpha = 1
                self.selectedImageContainer.isHidden = false
                self.flipButton.isEnabled = true
            })
            
            UIView.transition(with: imageTagView, duration: 1.0, options: transitionOptions, animations: {
                self.imageTagView.alpha = 0
                self.imageTagView.isHidden = true
                self.flipButton.isEnabled = true
            })
        }
    }
    
    func showTagsToUser() {
        tagsListLabel.text = ""
        for tag in selectedImageTags {
            tagsListLabel.text?.append("• \(tag.imageTag)\r")
        }
        
        quoteTitle.isHidden = false
        quoteLabel.isHidden = false
        if self.imageTagView.isHidden { self.flip() }
    }
    
    //    MARK: - Actions
    
    @objc func handleTapToSelectPhoto() {
        showImagePicker()
    }
    
    @objc func submitImage() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        guard selectedImage == selectedImage else { return }
        
        ImageUploader.uploadImage(selectedImage!) { id in
            self.requestTags(forId: id)
        }
        
        showLoader(true)
    }
    
    @objc func flipMainViews() {
        flip()
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
        dismiss(animated: true) {
            if !self.imageTagView.isHidden { self.flip() }
            self.tagsListLabel.text = "No tags found"
        }
    }
    
}
