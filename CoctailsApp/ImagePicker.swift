//
//  ImagePicker.swift
//  CoctailsApp
//
//  Created by user on 24.07.2025.
//

import UIKit

public protocol ImagePickerClassDelegate: AnyObject {
    func didSelect(image: UIImage?)
}

final class ImagePickerClass: NSObject {
    // MARK: - Property
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerClassDelegate?
    
    init(presentationController: UIViewController, delegate: ImagePickerClassDelegate) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = [Constants.mediaType]
    }
    
    // MARK: - Private Methods
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: Constants.takePhotoTitle) {
            alertController.addAction(action)
        }

        if let action = self.action(for: .photoLibrary, title: Constants.photoLibraryTitle) {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: Constants.cancelTitle, style: .cancel, handler: nil))
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ImagePickerClass: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePickerClass: UINavigationControllerDelegate {}

// MARK: - Constants
private extension ImagePickerClass {
    enum Constants {
        static let mediaType = "public.image"
        static let takePhotoTitle = "Take photo"
        static let photoLibraryTitle = "Photo library"
        static let cancelTitle = "Cancel"
    }
}
