//
//  AccointViewController.swift
//  
//
//  Created by Abdullah on 16/05/1446 AH.
//

import UIKit

class AccointViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var copyInstructionLabel: UILabel!
    @IBOutlet weak var emailDisplay: UITextView!
    
   
    override func viewDidLoad() {
            super.viewDidLoad()

            // إعداد عنوان "حسابك"
            titleLabel.text = "حسابك"
            titleLabel.textAlignment = .center // توسيط العنوان
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold) // تعيين حجم الخط

            // إعداد صورة افتراضية
            profileImage.image = UIImage(systemName: "person.crop.circle.badge.plus")
            profileImage.contentMode = .scaleAspectFill

            // استرجاع البريد الإلكتروني
            if let email = UserDefaults.standard.string(forKey: "userEmail") {
                emailDisplay.text = email
                emailDisplay.isEditable = false
                emailDisplay.isSelectable = true
            } else {
                emailDisplay.text = "البريد الإلكتروني غير متوفر"
                emailDisplay.isEditable = false
                emailDisplay.isSelectable = false
            }
        emailDisplay.font = UIFont.systemFont(ofSize: 18)

            // إضافة إيماءة التفاعل مع الصورة
            let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(PickProfileImage))
            profileImage.addGestureRecognizer(profileImageGesture)
            profileImage.isUserInteractionEnabled = true

            // إضافة إيماءة التفاعل مع البريد الإلكتروني
            let emailTapGesture = UITapGestureRecognizer(target: self, action: #selector(copyEmail))
            emailDisplay.addGestureRecognizer(emailTapGesture)

            // إعداد القيود
            setupConstraints()
        }

        @objc func PickProfileImage() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }

        @objc func copyEmail() {
            // نسخ البريد الإلكتروني إلى الحافظة
            UIPasteboard.general.string = emailDisplay.text
            
            // عرض تنبيه لتأكيد النسخ
            let alert = UIAlertController(title: "تم النسخ", message: "البريد الإلكتروني قد تم نسخه إلى الحافظة.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
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
            // إعداد قيود الصورة
            profileImage.translatesAutoresizingMaskIntoConstraints = false
            emailDisplay.translatesAutoresizingMaskIntoConstraints = false
            copyInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                // قيود لعنوان "حسابك"
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // المسافة من الجزء العلوي
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), // توسيط العنوان
                
                // قيود للصورة
                profileImage.widthAnchor.constraint(equalToConstant: 100),
                profileImage.heightAnchor.constraint(equalToConstant: 100),
                profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor), // توسيط الصورة
                profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20), // المسافة بين العنوان والصورة
                
                // قيود للبريد الإلكتروني
                emailDisplay.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20), // المسافة بين الصورة والبريد
                emailDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // المسافة من اليسار
                emailDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // المسافة من اليمين
                emailDisplay.heightAnchor.constraint(equalToConstant: 40), // ارتفاع ثابت لـ UITextView
                
                // قيود لتعليمات النسخ
                copyInstructionLabel.topAnchor.constraint(equalTo: emailDisplay.bottomAnchor, constant: 10), // المسافة بين البريد وتعليمات النسخ
                copyInstructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor) // توسيط التعليمات
            ])
            
            // إعداد تعليمات النسخ
            copyInstructionLabel.text = "يمكنك نسخ البريد الإلكتروني بالنقر عليه"
            copyInstructionLabel.textAlignment = .center
        }
    }
