//
//  AccointViewController.swift
//  
//
//  Created by Abdullah on 16/05/1446 AH.
//

import UIKit
import Firebase
import FirebaseAuth

class AccointViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var copyInstructionLabel: UILabel!
    
    
    @IBOutlet weak var emaildisplay: UITextView!
    
    @IBOutlet weak var gender: UISegmentedControl!
    
    @IBOutlet weak var birthday: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // إعداد العبارة "مرحباً"
        titleLabel.text = "مرحباً"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        // إعداد الصورة
        setupProfileImage()
        
        // إعداد تعليمات النسخ
        setupCopyInstructionLabel()
        firstname.font = UIFont.systemFont(ofSize: 20) // زيادة حجم خط الاسم الأول
        lastname.font = UIFont.systemFont(ofSize: 20)  // زيادة حجم خط الاسم الثاني
        emaildisplay.font = UIFont.systemFont(ofSize: 18)
        emaildisplay.textAlignment = .center
        // استرجاع البيانات المخزنة
        loadData()
        
        // إضافة إيماءة التفاعل مع الصورة
        setupProfileImageGesture()
        
        // إعداد البريد الإلكتروني
        setupEmailDisplay()
        
        // إعداد القيود
        setupConstraints()
    }
    
    private func setupEmailDisplay() {
        if let email = UserDefaults.standard.string(forKey: "userEmail") {
            emaildisplay.text = email
            emaildisplay.isEditable = false
            emaildisplay.isSelectable = true
        } else {
            emaildisplay.text = "البريد الإلكتروني غير متوفر"
            emaildisplay.isEditable = false
            emaildisplay.isSelectable = false
        }
        emaildisplay.font = UIFont.systemFont(ofSize: 18)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyEmail))
        emaildisplay.addGestureRecognizer(tapGesture)
    }
    
    @objc func copyEmail() {
        if let email = emaildisplay.text {
            UIPasteboard.general.string = email
            showAlert(title: "تم النسخ", message: "تم نسخ البريد الإلكتروني إلى الحافظة.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // جعل الصورة دائرية
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    private func setupProfileImage() {
        profileImage.image = UIImage(systemName: "person.crop.circle.fill")
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupCopyInstructionLabel() {
        copyInstructionLabel.text = "يمكنك نسخ البريد الإلكتروني بالنقر عليه"
        copyInstructionLabel.textAlignment = .center
        copyInstructionLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func setupProfileImageGesture() {
        let profileImageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImage.addGestureRecognizer(profileImageGesture)
        profileImage.isUserInteractionEnabled = true
    }
    
    @objc func selectImage() {
        let actionSheet = UIAlertController(title: "اختيار صورة", message: "اختر مصدر الصورة", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "الكاميرا", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "مكتبة الصور", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "خطأ", message: "الكاميرا غير متوفرة")
        }
    }
    
    func openPhotoLibrary() {
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
    
    private func loadData() {
        let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
        let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
        let birthDate = UserDefaults.standard.object(forKey: "birthDate") as? Date ?? Date()
        let genderr = UserDefaults.standard.string(forKey: "gender") ?? "ذكر"
        
        firstname.text = firstName
        lastname.text = lastName
        birthday.date = birthDate
        gender.selectedSegmentIndex = (genderr == "ذكر") ? 0 : 1
    }
    
    private func saveData() {
        UserDefaults.standard.set(firstname.text, forKey: "firstName")
        UserDefaults.standard.set(lastname.text, forKey: "lastName")
        UserDefaults.standard.set(birthday.date, forKey: "birthDate")
        let selectedGender = gender.selectedSegmentIndex == 0 ? "ذكر" : "أنثى"
        UserDefaults.standard.set(selectedGender, forKey: "gender")
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveData()
        showAlert(title: "تم الحفظ", message: "تم حفظ البيانات بنجاح.")
    }
    
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "toLoginpage", sender: nil)
            
        }catch let signOutError as NSError{
            print("Eroor logout:%@",signOutError)
        }
    }
    
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        firstname.translatesAutoresizingMaskIntoConstraints = false
        lastname.translatesAutoresizingMaskIntoConstraints = false
        emaildisplay.translatesAutoresizingMaskIntoConstraints = false
        copyInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
        birthday.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            firstname.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 30),
            firstname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastname.topAnchor.constraint(equalTo: firstname.bottomAnchor, constant: 20),
            lastname.leadingAnchor.constraint(equalTo: firstname.leadingAnchor),
            lastname.trailingAnchor.constraint(equalTo: firstname.trailingAnchor),
            
            emaildisplay.topAnchor.constraint(equalTo: lastname.bottomAnchor, constant: 20),
            emaildisplay.leadingAnchor.constraint(equalTo: firstname.leadingAnchor),
            emaildisplay.trailingAnchor.constraint(equalTo: firstname.trailingAnchor),
            emaildisplay.heightAnchor.constraint(equalToConstant: 40), // تحديد ارتفاع
            
            copyInstructionLabel.topAnchor.constraint(equalTo: emaildisplay.bottomAnchor, constant: 5),
            copyInstructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            birthday.topAnchor.constraint(equalTo: copyInstructionLabel.bottomAnchor, constant: 20),
            birthday.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            gender.topAnchor.constraint(equalTo: birthday.bottomAnchor, constant: 20),
            gender.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gender.widthAnchor.constraint(equalToConstant: 300),
            
            saveButton.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
