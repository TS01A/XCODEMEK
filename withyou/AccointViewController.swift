//
//  AccointViewController.swift
//  
//
//  Created by Abdullah on 16/05/1446 AH.
//

import UIKit

class AccointViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // إعداد صورة افتراضية
            profileImage.image = UIImage(systemName: "person.crop.circle.badge.plus") // استخدام صورة من SF Symbols
            
            // تعيين نمط المحتوى
            profileImage.contentMode = .scaleAspectFill // يملأ الصورة بشكل جيد

            
            
            // إضافة إيماءة التفاعل مع الصورة
            let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(PickProfileImage))
            profileImage.addGestureRecognizer(profileImageGesture)
            profileImage.isUserInteractionEnabled = true

            // قيود الصورة في يمين الشاشة من الأعلى
            setupConstraints()
        }

        @objc func PickProfileImage() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                profileImage.image = selectedImage
            }
            dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }

        private func setupConstraints() {
            // إضافة قيود للصورة (لتكون في يمين الشاشة من الأعلى)
            profileImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileImage.widthAnchor.constraint(equalToConstant: 100),  // عرض الصورة
                profileImage.heightAnchor.constraint(equalToConstant: 100), // ارتفاع الصورة
                profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // المسافة من اليمين
                profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40) // المسافة من الأعلى
            ])
        }
    }
